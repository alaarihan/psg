---
to: <%= name %>/src/server.ts
---

import fastify from 'fastify'
import mercurius from 'mercurius'
import { schema } from './schema'
import { createContext } from './context'

const app = fastify()

app.register(mercurius, {
  schema,
  context: createContext,
  graphiql: true
})


app.listen(3000).catch((err) => {
  console.log(err)
})