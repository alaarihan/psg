---
to: <%= name %>/src/common/noIntrospection.ts
---

import {
  ASTVisitor,
  FieldNode,
  getNamedType,
  GraphQLError,
  isIntrospectionType,
  ValidationContext,
} from 'graphql'

export function NoIntrospection(
  context: ValidationContext,
): ASTVisitor {
  return {
    Field(node: FieldNode) {
      if (process.env.INTROSPECTIONS !== 'on') {
        const type = getNamedType(context.getType())
        if (type && isIntrospectionType(type)) {
          context.reportError(
            new GraphQLError(
              `GraphQL introspection has been disabled, but the requested query contained the field "${node.name.value}".`,
              node,
            ),
          )
        }
      }
    },
  }
}
