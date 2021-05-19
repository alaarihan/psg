---
to: <%= options.dir %>/models/<%= name %>/mutations.ts
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
  createOne<%= name %>: {
    extensions: { 
      model:  '<%= name %>',
      op: 'createOne',
      permType: 'CREATE'
    },
    type: new GraphQLNonNull(<%= name %>),
    args: {
      data: { type: new GraphQLNonNull(<%= name %>CreateInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.create(args as any)
    },
  },
  updateOne<%= name %>: {
    extensions: { 
      model:  '<%= name %>',
      op: 'updateOne',
      permType: 'UPDATE'
    },
    type: new GraphQLNonNull(<%= name %>),
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereUniqueInput) },
      data: { type: new GraphQLNonNull(<%= name %>UpdateInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.update(args as any)
    },
  },
  deleteOne<%= name %>: {
     extensions: { 
      model:  '<%= name %>',
      op: 'deleteOne',
      permType: 'DELETE'
    },
    type: <%= name %>,
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereUniqueInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.delete(args as any)
    },
  },
  upsertOne<%= name %>: {
     extensions: { 
      model:  '<%= name %>',
      op: 'upsertOne',
      permType: 'UPSERT'
    },
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
     extensions: { 
      model:  '<%= name %>',
      op: 'createMany',
      permType: 'CREATE'
    },
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
    extensions: { 
      model:  '<%= name %>',
      op: 'updateMany',
      permType: 'UPDATE'
    },
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
    extensions: { 
      model:  '<%= name %>',
      op: 'deleteMany',
      permType: 'DELETE'
    },
    type: new GraphQLNonNull(AffectedRowsOutput),
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereInput) },
    },
    async resolve(_root, args, ctx) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.deleteMany(args as any)
    },
  },
}
