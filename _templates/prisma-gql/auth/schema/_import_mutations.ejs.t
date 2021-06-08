---
inject: true
to: <%= options.dir %>/schema.ts
prepend: true
skip_if: "{ authMutations }"
---

import { authMutations } from './auth'