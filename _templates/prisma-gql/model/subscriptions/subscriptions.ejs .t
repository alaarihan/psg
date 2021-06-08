---
to: <%= options.dir %>/models/<%= name %>/subscriptions.ts
---

import { GraphQLNonNull, GraphQLObjectType } from 'graphql'
import { <%= name %> } from './type'
import { <%= name %>WhereInput } from '../inputs'
import { SubscriptionOpernation } from '../enums'
import { subscribeFunction } from '../../common/subscribeFunc'

export const <%= name %>Subscription = new GraphQLObjectType({
  name: '<%= name %>Subscription',
  fields: () => ({
    operation: {
      type: new GraphQLNonNull(SubscriptionOpernation),
    },
    data: {
      type: new GraphQLNonNull(<%= name %>),
    },
  }),
})
export const <%= h.changeCase.camel(name) %>Subscriptions = {
  <%= h.changeCase.camel(name) %>: {
    extensions: { 
      model:  '<%= name %>',
      op: 'Subscription',
      permType: 'READ'
    },
    type: new GraphQLNonNull(<%= name %>Subscription),
    args: {
      where: { type: <%= name %>WhereInput },
    },
    subscribe: subscribeFunction,
    resolve: async (root, args, ctx) => {
      let data
      if(root.operation === '<%= name.toUpperCase() %>_DELETED'){
        data = { id: root.id }
      } else {
          data = await ctx.prisma.<%= h.changeCase.camel(name) %>.findUnique({
          where: { id: root.id },
          select: args.select.data.select,
        })
      }
      const result = {
        data,
        operation: root.operation,
      }
      return result
    },
  },
}
