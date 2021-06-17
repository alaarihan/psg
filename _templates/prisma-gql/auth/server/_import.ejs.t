---
inject: true
to: <%= options.dir %>/server.ts
after: "graphql-middleware"
skip_if: "{ acl, getRoleSchemaCache }"
---

import { acl, getRoleSchemaCache } from './auth'