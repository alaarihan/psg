---
inject: true
to: <%= options.dir %>/files.ts
after: "import path"
skip_if: "{ getUserFromRequest }"
---

import { getUserFromRequest } from './common/getUserFromRequest'
import { getRolePerms } from './auth'