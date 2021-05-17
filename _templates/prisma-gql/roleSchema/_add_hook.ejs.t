---
inject: true
to: <%= options.dir %>/server.ts
after: "await app.ready()"
skip_if: "{ getUserRoleSchema }"
---

  app.graphql.addHook(
    'preParsing',
    async function (_schema, _source, ctx) {
      try {
        const userRole = ctx.user?.role
        if (userRole) {
          const perms = await ctx.prisma.permission
            .findMany({
              where: { role: { equals: userRole } },
            })
            .catch((err) => {
              console.log(err)
            })
          if (!perms) throw new Error("perms couldn't be loaded by Prisma")
          const roleSchema = getUserRoleSchema(schemaWithMiddlewares, perms)
          ctx.app.graphql.replaceSchema(roleSchema)
        } else if (userRole === "ADMIN") {
          ctx.app.graphql.replaceSchema(schemaWithMiddlewares)
        }
      } catch (err) {
        console.log(err)
      }
    },
  )