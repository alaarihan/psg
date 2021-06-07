---
inject: true
to: <%= options.dir %>/prisma.ts
after: "{ PrismaClient }"
skip_if: "{ rolesPerms }"
---

import { rolesPerms } from './auth/src/common/permsCache'
