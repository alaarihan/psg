---
to: <%= options.dir %>/models/<%= name %>/mutations.ts
---

<%_
const createOneMutation = options.queryMap && options.queryMap.createOne ? options.queryMap.createOne(name) : `createOne${name}`
const updateOneMutation = options.queryMap && options.queryMap.updateOne ? options.queryMap.updateOne(name) : `updateOne${name}`
const deleteOneMutation = options.queryMap && options.queryMap.deleteOne ? options.queryMap.deleteOne(name) : `deleteOne${name}`
const upsertOneMutation = options.queryMap && options.queryMap.upsertOne ? options.queryMap.upsertOne(name) : `upsertOne${name}`
const createManyMutation = options.queryMap && options.queryMap.createMany ? options.queryMap.createMany(name) : `createMany${name}`
const updateManyMutation = options.queryMap && options.queryMap.updateMany ? options.queryMap.updateMany(name) : `updateMany${name}`
const deleteManyMutation = options.queryMap && options.queryMap.deleteMany ? options.queryMap.deleteMany(name) : `deleteMany${name}`
-%>

import {
  GraphQLBoolean,
  GraphQLNonNull,
  GraphQLList
} from 'graphql'
import { <%= name %> } from './type'
import { AffectedRowsOutput } from '../types'
import { <%= name %>CreateInput, <%= name %>UpdateInput, <%= name %>WhereUniqueInput, <%= name %>WhereInput, <%= name %>UpdateManyMutationInput, <%= name %>CreateManyInput } from '../inputs'
import { AppContext } from '../../context'

export const <%= h.changeCase.camel(name) %>Mutations = {
  <%= createOneMutation %>: {
    extensions: { 
      model:  '<%= name %>',
      op: 'createOne',
      permType: 'CREATE'
    },
    type: new GraphQLNonNull(<%= name %>),
    args: {
      data: { type: new GraphQLNonNull(<%= name %>CreateInput) },
    },
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.create(args)
    },
  },
  <%= updateOneMutation %>: {
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
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.update(args)
    },
  },
  <%= deleteOneMutation %>: {
     extensions: { 
      model:  '<%= name %>',
      op: 'deleteOne',
      permType: 'DELETE'
    },
    type: <%= name %>,
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereUniqueInput) },
    },
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.delete(args)
    },
  },
  <%= upsertOneMutation %>: {
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
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.upsert(args)
    },
  },
  <%= createManyMutation %>: {
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
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.createMany(args)
    },
  },
  <%= updateManyMutation %>: {
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
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.updateMany(args)
    },
  },
  <%= deleteManyMutation %>: {
    extensions: { 
      model:  '<%= name %>',
      op: 'deleteMany',
      permType: 'DELETE'
    },
    type: new GraphQLNonNull(AffectedRowsOutput),
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereInput) },
    },
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.deleteMany(args)
    },
  },
}
