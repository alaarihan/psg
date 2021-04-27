---
to: src/server.ts
sh: npm run prettier
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


app.listen(3000)