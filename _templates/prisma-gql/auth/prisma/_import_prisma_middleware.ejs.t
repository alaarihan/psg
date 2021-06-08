---
inject: true
to: <%= options.dir %>/prisma.ts
after: "{ PrismaClient }"
skip_if: "{ rolesPerms }"
---

import { rolePermsCache } from './auth/src/common/rolePerms'
