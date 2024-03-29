---
inject: true
to: <%= options.dir %>/server.ts
after: "await app.ready()"
skip_if: "await getRoleSchemaCache"
---

  app.graphql.addHook(
    'preParsing',
    async function (_schema, _source, ctx: AppContext) {
      try {
        if (ctx.user?.role !== 'ROOT') {
          const roleSchema = await getRoleSchemaCache(schemaWithMiddlewares, ctx.user.role)
          ctx.app.graphql.replaceSchema(roleSchema)
        } else {
          ctx.app.graphql.replaceSchema(schemaWithMiddlewares)
        }
      } catch (err) {
        throw err
      }
    },
  )
