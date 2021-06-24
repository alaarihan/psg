---
to: <%= name %>/src/server.ts
---

import fastify from 'fastify'
import mercurius from 'mercurius'
import { schema as mainSchema } from './schema'
import { createContext, AppContext } from './context'
import { applyMiddleware } from 'graphql-middleware'
import { prismaSelect, subscriptionsMiddleware } from './middlewares'

const schemaWithMiddlewares = applyMiddleware(
  mainSchema, 
  prismaSelect,
  subscriptionsMiddleware,
  // add_middlewares
)
const app = fastify()

async function start() {
  app.register(require('fastify-cors'), {
    origin: true,
    credentials: true,
  })
  app.register(require('fastify-cookie'))
  app.register(require('fastify-multipart'))
  
  app.register(require('./files'))

  app.register(mercurius, {
    schema: schemaWithMiddlewares,
    context: createContext,
    graphiql: 'playground',
    subscription: {
       context: (_, req) => {
        return createContext(req)
      },
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
