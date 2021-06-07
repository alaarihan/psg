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
          if(rolesPerms.get( ctx.user.role ) === undefined){
            await ctx.prisma.permission
            .findMany({
              where: {
                role: { equals: ctx.user.role },
              },
            }).then(res => {
              rolesPerms.set( ctx.user.role, res );
            })
            .catch((err) => {
              console.log(err)
              throw new Error('Something wrong happened!')
            })
            
          }
          const rolePerms = rolesPerms.get( ctx.user.role )
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
