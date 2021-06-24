---
inject: true
to: <%= options.dir %>/files.ts
after: "before_upload_checks"
skip_if: "fileCreatePerm"
---

const user = await getUserFromRequest(req, reply)
const perms = (await getRolePerms(user.role)) || []
const fileCreatePerm = perms.find(item => item.model === 'File' && item.type === 'CREATE')
if(!fileCreatePerm)  throw reply.code(401).type('text/plain').send('permission denied!')
// upload_permission_check_end
