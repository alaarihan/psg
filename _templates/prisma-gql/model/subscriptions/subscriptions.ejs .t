---
to: <%= options.dir %>/models/<%= name %>/subscriptions.ts
---

import { GraphQLNonNull, GraphQLObjectType } from 'graphql'
import { <%= name %> } from './type'
import { <%= name %>WhereInput, EnumPermissionTypeFilter } from '../inputs'
import { SubscriptionAction } from '../enums'
import { subscribeFunction } from '../../common/subscribeFunc'

export const <%= name %>Subscription = new GraphQLObjectType({
  name: '<%= name %>Subscription',
  fields: () => ({
    action: {
      type: new GraphQLNonNull(SubscriptionAction),
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
      action: { type: EnumPermissionTypeFilter },
    },
    subscribe: subscribeFunction,
    resolve: async (root, args, ctx) => {
      let data
      if(root.action === '<%= name.toUpperCase() %>_DELETED'){
        data = { id: root.id }
      } else {
          data = await ctx.prisma.<%= h.changeCase.camel(name) %>.findUnique({
          where: { id: root.id },
          select: args.select.data.select,
        })
      }
      const result = {
        data,
        action: root.action,
      }
      return result
    },
  },
}
