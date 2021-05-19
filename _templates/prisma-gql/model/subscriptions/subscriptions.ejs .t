---
to: <%= options.dir %>/models/<%= name %>/subscriptions.ts
---

import { GraphQLNonNull, GraphQLObjectType } from 'graphql'
import { <%= name %> } from './type'
import { <%= name %>WhereInput } from '../inputs'
import { SubscriptionOpernation } from '../enums'

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
    async subscribe(_root, _args, { pubsub }) {
      return pubsub.subscribe(
        '<%= name.toUpperCase() %>_CREATED',
        '<%= name.toUpperCase() %>_UPDATED',
        '<%= name.toUpperCase() %>_DELETED',
      )
    },
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
