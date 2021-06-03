---
inject: true
to: <%= options.dir %>/server.ts
after: "graphql-middleware"
skip_if: "{ jwtAuth, acl }"
---

import { jwtAuth, acl } from './auth'