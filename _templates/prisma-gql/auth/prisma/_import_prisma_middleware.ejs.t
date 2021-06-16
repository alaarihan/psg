---
inject: true
to: <%= options.dir %>/prisma.ts
after: "{ PrismaClient }"
skip_if: "{ rolePermsCache, roleSchemaCache }"
---

import { rolePermsCache, roleSchemaCache } from './auth'
