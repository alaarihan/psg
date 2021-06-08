---
to: <%= name %>/src/common/subscribeFunc.ts
---

const { withFilter } = require('mercurius')
import { camelCase } from 'change-case'

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
    if (args.where) {
      const where = { id: { equals: payload.id }, AND: args.where }
      const count = await ctx.prisma[camelCase(ext.model)]
        .count({
          where: where,
        })
        .catch((err) => {
          console.log(err)
        })
      if (!count) return false
    }
    // add_more_checkes
    return true
  },
)
