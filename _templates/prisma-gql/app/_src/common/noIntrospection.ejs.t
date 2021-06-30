---
to: <%= name %>/src/common/noIntrospection.ts
---

import { GraphQLError } from 'graphql'
/**
 * No introspection: __schema and __type are disallowed in the query.
 */
export function NoIntrospection(context) {
  return {
    Field(node) {
      if (
        process.env.INTROSPECTIONS !== 'on' &&
        (node.name.value === '__schema' || node.name.value === '__type')
      ) {
        context.reportError(
          new GraphQLError('GraphQL introspection is not allowed!', [node]),
        )
      }
    },
  }
}
