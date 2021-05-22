---
inject: true
to: <%= options.dir %>/server.ts
after: "await app.ready()"
skip_if: "{ getUserRoleSchema }"
---

  app.graphql.addHook(
    'preParsing',
    async function (_schema, _source, ctx: AppContext) {
      try {
        const userRole = ctx.user?.role
        if (userRole !== 'ADMIN') {
          const perms = await ctx.prisma.permission
            .findMany({
              where: { role: { equals: userRole } },
            })
            .catch((err) => {
              console.log(err)
            })
          const roleSchema = getUserRoleSchema(schemaWithMiddlewares, perms)
          ctx.app.graphql.replaceSchema(roleSchema)
        } else {
          ctx.app.graphql.replaceSchema(schemaWithMiddlewares)
        }
      } catch (err) {
        throw err
      }
    },
  )
