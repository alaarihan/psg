---
inject: true
to: <%= options.dir %>/server.ts
after: "graphql-middleware"
skip_if: "{ jwtAuth }"
---

import { jwtAuth } from './auth'