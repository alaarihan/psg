---
to: <%= name %>/src/schema.ts
---

import { GraphQLSchema, GraphQLObjectType } from 'graphql'

export const schema = new GraphQLSchema({
  query: new GraphQLObjectType({
    name: 'Query',
    fields: {
      // merge the query fields here
    }
  }),
  mutation: new GraphQLObjectType({
    name: 'Mutation',
    fields: {
      // merge the mutation fields here
    },
  }),
  subscription: new GraphQLObjectType({
    name: 'Subscription',
    fields: {
      // merge the subscription fields here
    },
  }),
})