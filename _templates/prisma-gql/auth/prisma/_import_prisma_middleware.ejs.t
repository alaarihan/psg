---
inject: true
to: <%= options.dir %>/prisma.ts
after: "{ PrismaClient }"
skip_if: "{ rolePermsCache }"
---

import { rolePermsCache } from './auth/src/common/rolePerms'
import { roleSchemaCache } from './auth/src/common/roleSchema'
