---
inject: true
to: <%= options.dir %>/server.ts
after: "'graphql-middleware'"
skip_if: "{ getUserRoleSchema }"
---

import { getUserRoleSchema } from './roleSchema'