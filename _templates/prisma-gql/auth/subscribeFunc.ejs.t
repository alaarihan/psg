---
to: <%= name %>/src/common/subscribeFunc.ts
---

const { withFilter } = require('mercurius')
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
    if (ctx.user?.role === 'ADMIN' || !ext.op) return true
    let where = { id: payload.id }
    if (args.where) {
      where = mergeCheckWithWhere(where, args.where)
    }
    const itemExists = await checkModelItemsExist(where, ctx, ext, false)
    return itemExists
  },
)
