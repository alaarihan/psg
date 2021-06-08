---
to: <%= options.dir %>/common/subscribeFunc.ts
---

const { withFilter } = require('mercurius')
import { camelCase } from 'change-case'
import { checkModelItemsExist, mergeCheckWithWhere } from '../auth'

export const subscribeFunction = withFilter(
  (root, args, { pubsub }, info) => {
    const ext = info.parentType.getFields()[info.fieldName].extensions
    const model = ext.model.toUpperCase()
    return pubsub.subscribe(
      `${model}_CREATED`,
      `${model}_UPDATED`,
      `${model}_DELETED`,
    )
  },
  async (payload, args, ctx, info) => {
    const ext = info.parentType.getFields()[info.fieldName].extensions
    if (!ext.op) return true
    const item = { id: payload.id }
    const where = { id: { equals: payload.id } }
    if (args.where) {
      const argsWhere = mergeCheckWithWhere(where, args.where)
      const item = await ctx.prisma[camelCase(ext.model)]
        .count({
          where: argsWhere,
        })
        .catch((err) => {
          console.log(err)
        })
      if (!item) return false
    }
    if (ctx.user?.role !== 'ADMIN') {
      const itemExists = await checkModelItemsExist(item, ctx, ext, false)
      return itemExists
    }
    return true
  },
)
