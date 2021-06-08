---
inject: true
to: <%= options.dir %>/common/subscribeFunc.ts
after: "{ withFilter }"
skip_if: "{ checkModelItemsExist }"
---

import { checkModelItemsExist } from '../auth'