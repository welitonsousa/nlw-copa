import { PrismaClient } from "@prisma/client";


async function main() {
  const prisma = new PrismaClient();
  const user = await prisma.user.create({
    data: {
      email: 'teste@gmail.com',
      name: 'wellington',
      googleID: '123',
      avatar: 'https://avatars.githubusercontent.com/u/64853142?v=4',
    }
  })
  const pool = await prisma.pool.create({
    data: {
      title: 'example pool',
      code: 'example',
      ownerId: user.id,
      participants: {
        create: {
          userId: user.id
        }
      }

    }
  })

  await prisma.game.create({
    data: {
      date: '2022-11-24T12:00:00.201Z',
      firstTeamCode: 'DE',
      secondTeamCode: 'BR',
    }
  })

  await prisma.game.create({
    data: {
      date: '2022-11-26T12:00:00.201Z',
      firstTeamCode: 'BR',
      secondTeamCode: 'AR',
      guesses: {
        create: {
          firstTeamPoints: 2,
          secondTeamPoints: 1,
          participant: {
            connect: {
              userId_poolId: {
                userId: user.id,
                poolId: pool.id,
              }
            }
          }
        }
      }
    }
  })

}
main()