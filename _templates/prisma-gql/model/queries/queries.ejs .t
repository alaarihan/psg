---
to: <%= options.dir %>/models/<%= name %>/queries.ts
---

<%_
const findUniqueQuery = options.queryMap && options.queryMap.findUnique ? options.queryMap.findUnique(name) : `findUnique${name}`
const findFirstQuery = options.queryMap && options.queryMap.findFirst ? options.queryMap.findFirst(name) : `findFirst${name}`
const findManyQuery = options.queryMap && options.queryMap.findMany ? options.queryMap.findMany(name) : `findMany${name}`
const countQuery = options.queryMap && options.queryMap.count ? options.queryMap.count(name) : `count${name}`
const aggregateQuery = options.queryMap && options.queryMap.aggregate ? options.queryMap.aggregate(name) : `aggregate${name}`
-%>

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
  <%= findUniqueQuery %>: {
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
  <%= findManyQuery %>: {
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
  <%= findFirstQuery %>: {
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
  <%= countQuery %>: {
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
  <%= aggregateQuery %>: {
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
