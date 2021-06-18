---
to: <%= name %>/src/common/subscribeFunc.ts
---

const { withFilter } = require('mercurius')
import { camelCase } from 'change-case'

export const subscribeFunction = withFilter(
  (root, args, { pubsub }, info) => {
    const ext = info.parentType.getFields()[info.fieldName].extensions
    const model = ext.model.toUpperCase()
    return pubsub.subscribe([
      `${model}_CREATED`,
      `${model}_UPDATED`,
      `${model}_DELETED`,
    ])
  },
  async (payload, args, ctx, info) => {
    const ext = info.parentType.getFields()[info.fieldName].extensions
    if (!ext.op) return true
    if (
      (args.action?.equals && args.action.equals !== payload.action) ||
      (args.action?.in && !args.action.in.includes(payload.action)) ||
      (args.action?.notIn && args.action.notIn.includes(payload.action)) ||
      (args.action?.not?.equals && args.action.not.equals === payload.action) ||
      (args.action?.not?.in && args.action.not.in.includes(payload.action)) ||
      (args.action?.not?.notIn && !args.action.not.notIn.includes(payload.action))
    ) {
      return false
    }
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
