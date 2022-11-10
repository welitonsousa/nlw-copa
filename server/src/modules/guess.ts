import { FastifyInstance } from "fastify"
import { z } from "zod"
import { prisma } from "../lib/fastify"

export async function guessRoutes(fastify: FastifyInstance) {
  fastify.get('/guesses/count', async () => {
    const count = await prisma.guess.count()
    return { count }
  })


  fastify.post('/pools/:poolId/games/:gameId/guesses', async (request, reply) => {
    await request.jwtVerify()

    interface Params { poolId: string, gameId: string }

    const validation = z.object({
      firstTeamPoints: z.number().int(),
      secondTeamPoints: z.number().int(),
    })

    const params = request.params as Params
    const {firstTeamPoints, secondTeamPoints} = await validation.parse(request.body)
    const pool = await prisma.pool.findUnique({ where: { id: params.poolId } })
    if (!pool) return reply.status(404).send({ message: 'pool not found' })

    const game = await prisma.game.findUnique({ where: { id: params.gameId } })
    if (!game) return reply.status(404).send({ message: 'game not found' })


    const participant = await prisma.participant.findUnique({
      where: {
        userId_poolId: {
          poolId: params.poolId,
          userId: request.user.sub,
        }
      }
    })
    if (!participant) return reply.status(400).send({ message: 'You\'re not allowed to create a guess inside this pool' })


    const guess = await prisma.guess.findUnique({
      where: {
        participantId_gameId: {
          gameId: params.gameId,
          participantId: request.user.sub,
        }
      }
    })
    if (guess) return reply.status(400).send({ message: 'You cannot send guesses after the game date' })
    if (game.date < new Date()) return reply.status(400).send({ message: '' })


    await prisma.guess.create({
      data: {
        participantId: participant.id,
        gameId: game.id,
        firstTeamPoints,
        secondTeamPoints,
      }
    })
  })


}