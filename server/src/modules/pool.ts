import { FastifyInstance } from "fastify"
import { z } from "zod"
import { prisma } from "../lib/fastify"
import ShortUniqueId from "short-unique-id"


export async function poolRoutes(fastify: FastifyInstance) {
  
  fastify.get('/pools/count', async () => {
    const count = await prisma.pool.count()
    return { count }
  })
  
  fastify.post('/pools', async (request, reply) => { 
    const body = z.object({ title: z.string().trim().min(1) })
    try {
      const { title } = body.parse(request.body)
      const createCode = new ShortUniqueId({ length: 6 })
      const code = String(createCode()).toLocaleUpperCase()
      const pool = await prisma.pool.create({
        data: { code, title }
      })
      return { pool }
    }catch(error){
      return reply.status(400).send( JSON.parse((error as any).message))
    }
  })



  fastify.post('/pools-signed', async (request, reply) => { 
    await request.jwtVerify()
    const body = z.object({ title: z.string().trim().min(1) })
    try {
      const { title } = body.parse(request.body) 
      const createCode = new ShortUniqueId({ length: 6 })
      const code = String(createCode()).toLocaleUpperCase()
      const pool = await prisma.pool.create({
        data: {
          code, title, ownerId: request.user.sub, participants: {
            create: {
              userId: request.user.sub
            }
          }
        }})
        return { pool }
    } catch (error) {
      return reply.status(400).send( JSON.parse((error as any).message))
    }
  })

  fastify.post('/pools/:code/join', async (request, reply) => {
    await request.jwtVerify()
    interface Params { code: string }
    const { code } = request.params as Params
    const pool = await prisma.pool.findUnique({
      where: { code },
      include: {
        participants: { where: { userId: request.user.sub } }
      }
    })
    if (!pool) return reply.status(404).send({ message: 'pool not found' })
    else if (pool.participants.length > 0) return reply.status(404).send({ message: 'You already joined this pool' })

    if (!pool.ownerId) {
      await prisma.pool.update({
        where: { id: pool.id },
        data: { ownerId: request.user.sub }
      })
    }

    await prisma.participant.create({
      data: {
        poolId: pool.id,
        userId: request.user.sub,
      }
    })
  })

  fastify.get('/pools', async (request) => {
    await request.jwtVerify()

    const pools = await prisma.pool.findMany({
      where: {
        participants: { some: { userId: request.user.sub } },
      },
      include: {
        _count: true,
        participants: {
          take: 5, select: {
            user: {
              select: { avatar: true, name: true, email: true, id: true }
            }
          }
        },
        owner: {
          select: { id: true, name: true, email: true, avatar: true }
        }

      }
    })
    return { pools }
  })

  fastify.get('/pools/:code', async (request, reply) => {
    await request.jwtVerify()

    interface Params { code: string }
    const { code } = request.params as Params

    const pool = await prisma.pool.findUnique({
      where: { code },
      include: {
        _count: true,
        participants: {
          take: 5, select: {
            user: {
              select: { avatar: true, name: true, email: true, id: true }
            }
          }
        },
        owner: {
          select: { id: true, name: true, email: true, avatar: true }
        }

      }
    })
    if (!pool)  return reply.status(404).send({ message: "pool not found" })
    
    return { pool }
  })
}