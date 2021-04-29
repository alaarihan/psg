---
to: src/models/<%= name %>/mutations.ts
force: true
---

import {
  GraphQLBoolean,
  GraphQLNonNull,
  GraphQLList
} from 'graphql'
import { <%= name %> } from './type'
import { AffectedRowsOutput } from '../types'
import { <%= name %>CreateInput, <%= name %>UpdateInput, <%= name %>WhereUniqueInput, <%= name %>WhereInput, <%= name %>UpdateManyMutationInput, <%= name %>CreateManyInput } from '../inputs'

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
  createMany<%= name %>: {
    type: new GraphQLNonNull(AffectedRowsOutput),
    args: {
      data: { type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(<%= name %>CreateManyInput))) },
      skipDuplicates:  { type: GraphQLBoolean }
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.createMany(args as any)
    },
  },
  updateMany<%= name %>: {
    type: new GraphQLNonNull(AffectedRowsOutput),
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereInput) },
      data: { type: new GraphQLNonNull(<%= name %>UpdateManyMutationInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.updateMany(args as any)
    },
  },
  deleteMany<%= name %>: {
    type: new GraphQLNonNull(AffectedRowsOutput),
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.deleteMany(args as any)
    },
  },
}
