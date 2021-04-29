---
to: src/models/types.ts
unless_exists: true
---

import {
  GraphQLInt,
  GraphQLNonNull,
  GraphQLObjectType,
} from 'graphql'

export const AffectedRowsOutput = new GraphQLObjectType({
  name: 'AffectedRowsOutput',
  fields: () => ({
    count: {
      type: new GraphQLNonNull(GraphQLInt),
    },
  }),
})
