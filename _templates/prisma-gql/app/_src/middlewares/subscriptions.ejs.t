---
to: <%= name %>/src/middlewares/subscriptions.ts
---

export const subMiddleware = async (resolve, root, args, ctx, info) => {
  const rootTypes = ['Query', 'Mutation']
  if (rootTypes.includes(info.path.typename)) {
    const operations = {
      in: ['create', 'update', 'delete'],
      notIn: ['createMany', 'updateMany', 'deleteMany'],
    }
    if (
      operations.in.some((op) => info.fieldName.startsWith(op)) &&
      !operations.notIn.some((op) => info.fieldName.startsWith(op))
    ) {
      args.select.id = true
      const result = await resolve(root, args, ctx, info)
      if (result && result.id) {
        const op = operations.in.find((op) => info.fieldName.startsWith(op))
        const eventName = `${info.returnType.ofType.name}_${op}d`
        ctx.pubsub.publish({
          topic: eventName.toUpperCase(),
          payload: { id: result.id, operation: op.toUpperCase() },
        })
      }
      return result
    }
  }

  return resolve(root, args, ctx, info)
}
