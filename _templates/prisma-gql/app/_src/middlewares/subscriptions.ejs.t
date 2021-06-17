---
to: <%= name %>/src/middlewares/subscriptions.ts
---

export const subscriptionsMiddleware = async (resolve, root, args, ctx, info) => {
  if (info.path.typename === 'Mutation') {
    const ext = info.parentType.getFields()[info.fieldName].extensions

    if (['createOne', 'updateOne', 'deleteOne'].includes(ext.op)) {
      args.select.id = true
      const result = await resolve(root, args, ctx, info)
      if (result && result.id) {
        const op = ext.op.slice(0, -3)
        const eventName = `${info.returnType.ofType.name}_${op}d`
        ctx.pubsub.publish({
          topic: eventName.toUpperCase(),
          payload: { id: result.id, action: op.toUpperCase() },
        })
      }
      return result
    }
  }

  return resolve(root, args, ctx, info)
}
