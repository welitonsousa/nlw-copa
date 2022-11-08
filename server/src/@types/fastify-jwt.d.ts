import '@fastify/jwt'

declare module '@fastify/jwt' {
  interface FastifyJWT {
    user: {
      name: string;
      avatar: string?;
      email: string;
      sub: string;
    }
  }
}