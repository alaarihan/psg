---
inject: true
to: <%= options.dir %>/schema.ts
prepend: true
skip_if: "{ <%= h.changeCase.camel(name) %>Subscriptions }"
---

import { <%= h.changeCase.camel(name) %>Subscriptions } from './models/subscriptions' 