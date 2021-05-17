---
to: <%= name %>/src/server.ts
---

require('dotenv').config()
import fastify from 'fastify'
import mercurius from 'mercurius'
import { schema as mainSchema } from './schema'
import { createContext } from './context'
import { applyMiddleware } from 'graphql-middleware'
import { prismaSelect } from './middlewares/prismaSelect'

const schemaWithMiddelewares = applyMiddleware(mainSchema, prismaSelect)
const app = fastify()

async function start() {
  const app = fastify()

  app.register(mercurius, {
    schema: schemaWithMiddlewares,
    context: createContext,
    graphiql: 'playground',
    subscription: {
      context: createContext,
    },
    allowBatchedQueries: true,
  })

  await app.ready()

  app
    .listen(3000)
    .then(() =>
      console.log(`🚀 Server ready at http://localhost:3000/playground`),
    )
    .catch((err) => {
      console.log(err)
    })
}

start()
