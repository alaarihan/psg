---
to: <%= options.dir %>/models/<%= name %>/queries.ts
---

import {
  GraphQLInt,
  GraphQLList,
  GraphQLNonNull
} from 'graphql'
import { <%= name %>, Aggregate<%= name %> } from './type'
import { <%= name %>WhereUniqueInput, <%= name %>WhereInput, <%= name %>OrderByWithRelationInput} from '../inputs'
import { <%= name %>ScalarFieldEnum } from '../enums'
import { AppContext } from '../../context'
export const <%= h.changeCase.camel(name) %>Queries = {
  findUnique<%= name %>: {
    extensions: { 
      model:  '<%= name %>',
      op: 'findUnique',
      permType: 'READ'
    },
    type: <%= name %>,
    args: {
      where: { type: new GraphQLNonNull(<%= name %>WhereUniqueInput) },
    },
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.findUnique(args)
    },
  },
  findFirst<%= name %>: {
    extensions: { 
      model:  '<%= name %>',
      op: 'findFirst',
      permType: 'READ'
    },
    type: <%= name %>,
    args: {
      where: { type: <%= name %>WhereInput },
      orderBy: { type: new GraphQLList(<%= name %>OrderByWithRelationInput) },
      cursor: { type: <%= name %>WhereUniqueInput},
      skip: { type: GraphQLInt },
      take: { type: GraphQLInt },
      distinct: { type: new GraphQLList(<%= name %>ScalarFieldEnum) },
    },
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.findFirst(args)
    },
  },
  findMany<%= name %>: {
    extensions: { 
      model:  '<%= name %>',
      op: 'findMany',
      permType: 'READ'
    },
    type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(<%= name %>))),
    args: {
      where: { type: <%= name %>WhereInput },
      orderBy: { type: new GraphQLList(<%= name %>OrderByWithRelationInput) },
      cursor: { type: <%= name %>WhereUniqueInput},
      skip: { type: GraphQLInt },
      take: { type: GraphQLInt },
      distinct: { type: new GraphQLList(<%= name %>ScalarFieldEnum) },
    },
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.findMany(args)
    },
  },
  count<%= name %>: {
    extensions: { 
      model:  '<%= name %>',
      op: 'count',
      permType: 'READ'
    },
    type: new GraphQLNonNull(GraphQLInt),
    args: {
      where: { type: <%= name %>WhereInput },
      orderBy: { type: new GraphQLList(<%= name %>OrderByWithRelationInput) },
      cursor: { type: <%= name %>WhereUniqueInput},
      skip: { type: GraphQLInt },
      take: { type: GraphQLInt },
      distinct: { type: new GraphQLList(<%= name %>ScalarFieldEnum) },
    },
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.count(args)
    },
  },
  aggregate<%= name %>: {
    extensions: { 
      model:  '<%= name %>',
      op: 'aggregate',
      permType: 'READ'
    },
    type: new GraphQLNonNull(Aggregate<%= name %>),
    args: {
      where: { type: <%= name %>WhereInput },
      orderBy: { type: new GraphQLList(<%= name %>OrderByWithRelationInput) },
      cursor: { type: <%= name %>WhereUniqueInput},
      skip: { type: GraphQLInt },
      take: { type: GraphQLInt },
    },
    async resolve(_root, args, ctx: AppContext) {
      return ctx.prisma.<%= h.changeCase.camel(name) %>.aggregate(args)
    },
  },
}
