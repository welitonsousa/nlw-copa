import Fastify from "fastify"
import cors from "@fastify/cors"
import { userRoutes } from "./modules/user"
import { guessRoutes } from "./modules/guess"
import { poolRoutes } from "./modules/pool"
import { authRoutes } from "./modules/auth"
import jwt from "@fastify/jwt"
import fastifyCookie from "@fastify/cookie"
import { gameRoutes } from "./modules/game"


async function bootstrap() {
  const fastify = Fastify({ logger: true })
  await fastify.register(cors, { origin: true })

  const secret = process.env.JWT_SECRET || ''
  fastify.register(jwt, {secret})
  fastify.register(fastifyCookie, {secret})
  
  fastify.register(poolRoutes)
  fastify.register(userRoutes)
  fastify.register(guessRoutes)
  fastify.register(authRoutes)
  fastify.register(gameRoutes)

  fastify.listen({ port: 3333})
}

bootstrap()