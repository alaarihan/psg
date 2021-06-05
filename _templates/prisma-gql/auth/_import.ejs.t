---
inject: true
to: <%= options.dir %>/server.ts
after: "graphql-middleware"
skip_if: "{ jwtAuth, acl, getUserSchema }"
---

import { jwtAuth, acl, getUserSchema } from './auth'