---
to: src/models/<%= name %>/mutations.ts
force: true
---

import {
  GraphQLInt,
  GraphQLList,
  GraphQLNonNull,
  GraphQLObjectType,
} from 'graphql'
import { <%= name %> } from './type'
import { BatchPayload } from '../types'
import { <%= name %>CreateInput, <%= name %>UpdateInput, <%= name %>WhereUniqueInput, <%= name %>WhereInput, <%= name %>OrderByInput, <%= name %>UpdateManyMutationInput } from '../inputs'
import { <%= name %>ScalarFieldEnum } from '../enums'

export const <%= h.changeCase.camel(name) %>Mutations = {
  create<%= name %>: {
    type: <%= name %>,
    args: {
      data: { type: <%= name %>CreateInput },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.create(args as any)
    },
  },
  update<%= name %>: {
    type: <%= name %>,
    args: {
      where: { type: <%= name %>WhereUniqueInput },
      data: { type: <%= name %>UpdateInput },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.update(args as any)
    },
  },
  delete<%= name %>: {
    type: <%= name %>,
    args: {
      where: { type: <%= name %>WhereUniqueInput },
      data: { type: <%= name %>UpdateInput },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.delete(args as any)
    },
  },
  upsert<%= name %>: {
    type: <%= name %>,
    args: {
      where: { type: <%= name %>WhereUniqueInput },
      create: { type: <%= name %>CreateInput },
      update: { type: <%= name %>UpdateInput },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.upsert(args as any)
    },
  },
  updateMany<%= name %>: {
    type: BatchPayload,
    args: {
      where: { type: <%= name %>WhereInput },
      data: { type: <%= name %>UpdateManyMutationInput },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.updateMany(args as any)
    },
  },
  deleteMany<%= name %>: {
    type: BatchPayload,
    args: {
      where: { type: <%= name %>WhereInput },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.deleteMany(args as any)
    },
  },
}
