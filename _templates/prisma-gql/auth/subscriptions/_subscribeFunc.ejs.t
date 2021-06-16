---
inject: true
to: <%= options.dir %>/common/subscribeFunc.ts
after: "add_more_checkes"
skip_if: "await checkModelItemsExist"
---

if (ctx.user?.role !== 'ROOT') {
  const item = { id: payload.id }
  const itemExists = await checkModelItemsExist(item, ctx, ext, false)
  return itemExists
}