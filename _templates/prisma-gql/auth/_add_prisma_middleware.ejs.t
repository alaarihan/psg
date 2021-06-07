---
inject: true
to: <%= options.dir %>/prisma.ts
after: "add_prisma_middlewares"
skip_if: "rolesPerms.flushAll()"
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
        rolesPerms.flushAll()
    }
    return next(params)
})
