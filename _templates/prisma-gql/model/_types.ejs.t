---
to: src/models/types.ts
unless_exists: true
---

import {
  GraphQLInt,
  GraphQLNonNull,
  GraphQLObjectType,
} from 'graphql'

export const BatchPayload = new GraphQLObjectType({
  name: 'BatchPayload',
  fields: () => ({
    count: {
      type: new GraphQLNonNull(GraphQLInt),
    },
  }),
})
