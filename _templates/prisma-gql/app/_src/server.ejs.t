---
to: <%= name %>/src/server.ts
---

import fastify from 'fastify'
import mercurius from 'mercurius'
import { schema as mainSchema } from './schema'
import { createContext } from './context'
import { applyMiddleware } from 'graphql-middleware'
import { prismaSelect } from './middlewares/prismaSelect'

const schemaWithMiddelewares = applyMiddleware(mainSchema, prismaSelect)
const app = fastify()

app.register(mercurius, {
  schema: schemaWithMiddelewares,
  context: createContext,
  subscription: {
    context: createContext,
  },
  allowBatchedQueries: true
  graphiql: 'playground',
})


app.listen(3000).catch((err) => {
  console.log(err)
})