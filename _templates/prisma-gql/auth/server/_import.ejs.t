---
inject: true
to: <%= options.dir %>/server.ts
after: "graphql-middleware"
skip_if: "{ jwtAuth, acl, getRoleSchemaCache }"
---

import { jwtAuth, acl, getRoleSchemaCache } from './auth'