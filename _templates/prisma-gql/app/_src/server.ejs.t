---
to: <%= name %>/src/server.ts
---

import { networkInterfaces } from 'os'
import fastify from 'fastify'
import mercurius from 'mercurius'
import { applyMiddleware } from 'graphql-middleware'
import { schema as mainSchema } from './schema'
import { createContext, AppContext } from './context'
import { prismaSelect, subscriptionsMiddleware } from './middlewares'
import { NoIntrospection } from './common/noIntrospection'

const schemaWithMiddlewares = applyMiddleware(
  mainSchema, 
  prismaSelect,
  subscriptionsMiddleware,
  // add_middlewares
)
const app = fastify()

async function start() {
  app.register(require('@fastify/cors'), {
    origin: true,
    credentials: true,
  })
  app.register(require('@fastify/cookie'))
  app.register(require('@fastify/multipart'))

  app.register(mercurius, {
    schema: schemaWithMiddlewares,
    context: createContext,
    graphiql: process.env.INTROSPECTIONS==='on',
    subscription: {
       context: (_, req) => {
        return createContext(req)
      },
    },
    allowBatchedQueries: true,
    validationRules: [NoIntrospection],
  })

  await app.ready()

  const interfaces = networkInterfaces()
  app
    .listen({ port: parseInt(process.env.PORT) || 3000, host: '0.0.0.0' })
    .then(() => {
      console.log(`🚀 Server ready at:`)
      for (const key in interfaces) {
        if (Object.prototype.hasOwnProperty.call(interfaces, key)) {
          console.log(
            `http://${interfaces[key][0].address}:${
              process.env.PORT || 3000
            }/graphql`,
          )
        }
      }
    })
    .catch((err) => {
      console.log(err)
    })
}

start()
