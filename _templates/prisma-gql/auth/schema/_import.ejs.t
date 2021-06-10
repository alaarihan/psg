---
inject: true
to: <%= options.dir %>/schema.ts
prepend: true
skip_if: "{ authMutations, authQueries }"
---

import { authMutations, authQueries } from './auth'