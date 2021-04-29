---
to: src/models/<%= name %>/queries.ts
force: true
---

import {
  GraphQLInt,
  GraphQLList,
  GraphQLNonNull
} from 'graphql'
import { <%= name %> } from './type'
import { <%= name %>WhereUniqueInput, <%= name %>WhereInput, <%= name %>OrderByInput} from '../inputs'
import { <%= name %>ScalarFieldEnum } from '../enums'
export const <%= h.changeCase.camel(name) %>Queries = {
  <%= h.changeCase.camel(name) %>: {
    type: <%= name %>,
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereUniqueInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.findUnique(args as any)
    },
  },
  findFirst<%= name %>: {
    type: <%= name %>,
    args: {
      where: { type: <%= name %>WhereInput },
      orderBy: { type: new GraphQLList(<%= name %>OrderByInput) },
      cursor: { type: <%= name %>WhereUniqueInput},
      skip: { type: GraphQLInt },
      take: { type: GraphQLInt },
      distinct: { type: new GraphQLList(<%= name %>ScalarFieldEnum) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.findFirst(args as any)
    },
  },
  <%= h.inflection.pluralize(h.changeCase.camel(name)) %>: {
    type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(<%= name %>))),
    args: {
      where: { type: <%= name %>WhereInput },
      orderBy: { type: new GraphQLList(<%= name %>OrderByInput) },
      cursor: { type: <%= name %>WhereUniqueInput},
      skip: { type: GraphQLInt },
      take: { type: GraphQLInt },
      distinct: { type: new GraphQLList(<%= name %>ScalarFieldEnum) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.findMany(args as any)
    },
  },
  <%= h.inflection.pluralize(h.changeCase.camel(name)) %>Count: {
    type: new GraphQLNonNull(GraphQLInt),
    args: {
      where: { type: <%= name %>WhereInput },
      orderBy: { type: new GraphQLList(<%= name %>OrderByInput) },
      cursor: { type: <%= name %>WhereUniqueInput},
      skip: { type: GraphQLInt },
      take: { type: GraphQLInt },
      distinct: { type: new GraphQLList(<%= name %>ScalarFieldEnum) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.count(args as any)
    },
  },
}
