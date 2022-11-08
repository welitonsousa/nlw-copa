import { FastifyInstance } from "fastify"
import { prisma } from "../lib/fastify"

export async function userRoutes(fastify: FastifyInstance) {
  fastify.get('/users/count', async () => {    
    const count = await prisma.user.count()
    return { count }
  })

  fastify.get('/users/me', async (request) => {    
    await request.jwtVerify()
    const user = request.user
    return { user }
  })
}