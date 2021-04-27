---
to: src/models/<%= name %>/queries.ts
force: true
---

import {
  GraphQLInt,
  GraphQLList,
  GraphQLObjectType,
} from 'graphql'
import { <%= name %> } from './type'
import { <%= name %>WhereUniqueInput, <%= name %>WhereInput, <%= name %>OrderByInput,  } from '../inputs'

export const <%= h.changeCase.camel(name) %>Queries = {
  <%= h.changeCase.camel(name) %>: {
    type: <%= name %>,
    args: {
      where: { type: <%= name %>WhereUniqueInput },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.findUnique(args as any)
    },
  },
  findFirst<%= name %>: {
    type: <%= name %>,
    args: {
      where: { type: <%= name %>WhereInput },
      orderBy: { type: <%= name %>OrderByInput },
      cursor: { type: <%= name %>WhereUniqueInput},
      skip: { type: GraphQLInt },
      take: { type: GraphQLInt },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.findFirst(args as any)
    },
  },
  <%= h.inflection.pluralize(h.changeCase.camel(name)) %>: {
    type: new GraphQLList(<%= name %>),
    args: {
      where: { type: <%= name %>WhereInput },
      orderBy: { type: <%= name %>OrderByInput },
      cursor: { type: <%= name %>WhereUniqueInput},
      skip: { type: GraphQLInt },
      take: { type: GraphQLInt },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.findMany(args as any)
    },
  },
  <%= h.inflection.pluralize(h.changeCase.camel(name)) %>Count: {
    type: GraphQLInt,
    args: {
      where: { type: <%= name %>WhereInput },
      orderBy: { type: <%= name %>OrderByInput },
      cursor: { type: <%= name %>WhereUniqueInput},
      skip: { type: GraphQLInt },
      take: { type: GraphQLInt },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.count(args as any)
    },
  },
}
