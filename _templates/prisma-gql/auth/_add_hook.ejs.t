---
inject: true
to: <%= options.dir %>/server.ts
after: "await app.ready()"
skip_if: "{ getUserSchema }"
---

  app.graphql.addHook(
    'preParsing',
    async function (_schema, _source, ctx: AppContext) {
      try {
        if (ctx.user?.role !== 'ADMIN') {
          const rolePerms = await getRolePerms(ctx.user.role)
          const userSchema = getUserSchema(schemaWithMiddlewares, rolePerms)
          ctx.app.graphql.replaceSchema(userSchema)
        } else {
          ctx.app.graphql.replaceSchema(schemaWithMiddlewares)
        }
      } catch (err) {
        throw err
      }
    },
  )
