import { FastifyInstance } from "fastify";
import { prisma } from "../lib/fastify";

export async function gameRoutes(fastify: FastifyInstance) {
  fastify.get('/pools/:code/games', async (request, reply) => {
    interface Params { code: string }

    await request.jwtVerify()
    const { code } = request.params as Params;
    
    const  pool = await prisma.pool.findUnique({where: { code }})
    if (!pool) return reply.status(404).send({message: 'pool not found'})

    const games = await prisma.game.findMany({
      orderBy: { date: 'desc' },
      include: {
        guesses: {
          where: {
            participant: {  
              pool: { code },
              userId: request.user.sub
            }, 

          }
        }
      }
    })
    return {
      games: games.map((e) => {
        return {
          ...e,
          guess: e.guesses[0] ?? null,
          guesses: undefined,
        }
      })
    }
  })
  fastify.get('/games', async (request) => {
    await request.jwtVerify()
    const games = await prisma.game.findMany({
      orderBy: { date: 'desc' },
    })
    return { games }
  })

}