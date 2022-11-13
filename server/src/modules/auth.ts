import { FastifyInstance } from "fastify"
import { z } from "zod"
import { prisma } from "../lib/fastify"

export async function authRoutes(fastify: FastifyInstance) {
  
  fastify.post('/users', async (request, reply) => {
    const body = z.object({
      access_token: z.string().min(2),
    })
    
    const {access_token} = body.parse(request.body)

    const userResponse = await fetch('https://www.googleapis.com/oauth2/v2/userinfo', {
      headers: { Authorization: `Bearer ${access_token}` }
    })

    const userData = await userResponse.json()    
    
    if (userData) {
      const res = await prisma.user.findUnique({where: {googleID: userData.id}})
     
      if (!res){
        const user = await prisma.user.create({
          data: {
            googleID: userData.id,
            email: userData.email,
            name: userData.name,
            avatar: userData.picture,
          }
        })
        const token = fastify.jwt.sign({
          name: user.name,
          avatar: user.avatar,
          email: user.email,
        }, {
          sub: user.id,
          expiresIn: '10 days',
        })
        return { token }
      } else {
        const token = fastify.jwt.sign({
          name: res.name,
          avatar: res.avatar,
          email: res.email,
        }, {
          sub: res.id,
          expiresIn: '10 days',
        })
        return { token }
      }
    
    } else {
      return reply.status(500).send()
    }
   
  })
}