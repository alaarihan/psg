---
to: <%= name %>/src/server.ts
---

import fastify from 'fastify'
import mercurius from 'mercurius'
import { schema as mainSchema } from './schema'
import { createContext, AppContext } from './context'
import { applyMiddleware } from 'graphql-middleware'
import { prismaSelect } from './middlewares/prismaSelect'

const schemaWithMiddlewares = applyMiddleware(
  mainSchema, 
  prismaSelect,
  // add_middlewares
)
const app = fastify()

async function start() {
   app.register(require('fastify-cors'), {
    // put your cors options here
  })

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
