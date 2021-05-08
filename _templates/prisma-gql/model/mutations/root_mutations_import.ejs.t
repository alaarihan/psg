---
inject: true
to: <%= options.dir %>/schema.ts
prepend: true
skip_if: "{ <%= h.changeCase.camel(name) %>Mutations }"
---

import { <%= h.changeCase.camel(name) %>Mutations } from './models/mutations' 