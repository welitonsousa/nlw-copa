import Fastify from "fastify"
import cors from "@fastify/cors"
import { userRoutes } from "./modules/user"
import { guessRoutes } from "./modules/guess"
import { poolRoutes } from "./modules/pool"
import { authRoutes } from "./modules/auth"
import jwt from "@fastify/jwt"
import fastifyCookie from "@fastify/cookie"
import fastifySwagger from "@fastify/swagger"
import { gameRoutes } from "./modules/game"


async function bootstrap() {
  const fastify = Fastify({ logger: true })
  await fastify.register(cors, { origin: true })

  const secret = process.env.JWT_SECRET || ''
  fastify.register(jwt, {
    secret: secret,
    sign: { expiresIn: '10m' },
    cookie: {
      cookieName: 'refreshToken',
      signed: true,
    },

  })
  fastify.register(fastifyCookie, { secret })
  // fastify.register(fastifySwagger, {
  //   swagger: {
  //     info: {
  //       title: 'Test swagger',
  //       description: 'Testing the Fastify swagger API',
  //       version: '0.1.0'
  //     },
  //     externalDocs: {
  //       url: 'https://swagger.io',
  //       description: 'Find more info here'
  //     },
  //     host: 'localhost',
  //     schemes: ['http'],
  //     consumes: ['application/json'],
  //     produces: ['application/json'],
  //     tags: [
  //       { name: 'user', description: 'User related end-points' },
  //       { name: 'code', description: 'Code related end-points' }
  //     ],
  //     definitions: {
  //       User: {
  //         type: 'object',
  //         required: ['id', 'email'],
  //         properties: {
  //           id: { type: 'string', format: 'uuid' },
  //           firstName: { type: 'string' },
  //           lastName: { type: 'string' },
  //           email: {type: 'string', format: 'email' }
  //         }
  //       }
  //     },
  //     securityDefinitions: {
  //       apiKey: {
  //         type: 'apiKey',
  //         name: 'apiKey',
  //         in: 'header'
  //       }
  //     }
  //   }
  // })


  fastify.get('/cookies', async (request, reply) => {

    const token = await reply.jwtSign({
      name: 'foo'
    })

    const refreshToken = await reply.jwtSign({
      name: 'bar'
    }, { expiresIn: '1d' })

    reply.setCookie('refreshToken', refreshToken, {
      domain: 'your.domain',
      path: '/',
      secure: true, // send cookie over HTTPS only
      httpOnly: true,
      sameSite: true // alternative CSRF protection
    })
      .code(200)
      .send({ token })
  })

  fastify.post('/refresh-token', async (request, reply) => {
    const token = (request.body as any).refresh
    const res = await request.signCookie(token)
    return { token: res }
  })

  fastify.get('/refresh-token', async (request, reply) => {
    await request.jwtVerify()
  })


  fastify.register(poolRoutes)
  fastify.register(userRoutes)
  fastify.register(guessRoutes)
  fastify.register(authRoutes)
  fastify.register(gameRoutes)

  fastify.listen({ port: 3333, host: '0.0.0.0'})
}

bootstrap()