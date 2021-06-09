---
inject: true
to: <%= options.dir %>/server.ts
after: "graphql-middleware"
skip_if: "{ jwtAuth, acl, getRoleSchema }"
---

import { jwtAuth, acl, getRoleSchema } from './auth'