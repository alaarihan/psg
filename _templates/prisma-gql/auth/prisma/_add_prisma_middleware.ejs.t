---
inject: true
to: <%= options.dir %>/prisma.ts
after: "add_prisma_middlewares"
skip_if: "rolePermsCache.flushAll()"
---

prisma.$use(async (params, next) => {
    if (
        params.model == 'Permission' &&
        [
            'create',
            'createMany',
            'update',
            'updateMany',
            'delete',
            'deleteMany',
        ].includes(params.action)
    ) {
        rolePermsCache.flushAll()
        roleSchemaCache.flushAll()
    }
    return next(params)
})
