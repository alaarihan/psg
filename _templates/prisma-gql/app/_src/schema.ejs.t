---
to: <%= name %>/src/schema.ts
---

import { GraphQLSchema, GraphQLObjectType, GraphQLString } from 'graphql'

export const schema = new GraphQLSchema({
  query: new GraphQLObjectType({
    name: 'Query',
    fields: {
      // merge_the_query_fields_here
    }
  }),
  mutation: new GraphQLObjectType({
    name: 'Mutation',
    fields: {
      // merge_the_mutation_fields_here
    },
  }),
  subscription: new GraphQLObjectType({
    name: 'Subscription',
    fields: {
      // merge_the_subscription_fields_here
    },
  }),
})