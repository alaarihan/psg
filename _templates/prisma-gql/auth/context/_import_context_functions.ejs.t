---
inject: true
to: <%= options.dir %>/context.ts
after: "MercuriusContext"
skip_if: "{ getUserFromRequest }"
---

import { getUserFromRequest } from './common/getUserFromRequest'