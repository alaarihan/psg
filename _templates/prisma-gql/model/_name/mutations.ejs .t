---
to: src/models/<%= name %>/mutations.ts
force: true
---

import {
  GraphQLNonNull,
} from 'graphql'
import { <%= name %> } from './type'
import { BatchPayload } from '../types'
import { <%= name %>CreateInput, <%= name %>UpdateInput, <%= name %>WhereUniqueInput, <%= name %>WhereInput, <%= name %>UpdateManyMutationInput } from '../inputs'

export const <%= h.changeCase.camel(name) %>Mutations = {
  create<%= name %>: {
    type: new GraphQLNonNull(<%= name %>),
    args: {
      data: { type: new GraphQLNonNull(<%= name %>CreateInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.create(args as any)
    },
  },
  update<%= name %>: {
    type: new GraphQLNonNull(<%= name %>),
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereUniqueInput) },
      data: { type: new GraphQLNonNull(<%= name %>UpdateInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.update(args as any)
    },
  },
  delete<%= name %>: {
    type: <%= name %>,
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereUniqueInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.delete(args as any)
    },
  },
  upsert<%= name %>: {
    type: new GraphQLNonNull(<%= name %>),
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereUniqueInput) },
      create: { type: new GraphQLNonNull(<%= name %>CreateInput) },
      update: { type: new GraphQLNonNull(<%= name %>UpdateInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.upsert(args as any)
    },
  },
  updateMany<%= name %>: {
    type: new GraphQLNonNull(BatchPayload),
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereInput) },
      data: { type: new GraphQLNonNull(<%= name %>UpdateManyMutationInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.updateMany(args as any)
    },
  },
  deleteMany<%= name %>: {
    type: new GraphQLNonNull(BatchPayload),
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.deleteMany(args as any)
    },
  },
}
