---
inject: true
to: src/schema.ts
prepend: true
skip_if: "{ <%= h.changeCase.camel(name) %>Queries }"
---

import {<%= h.changeCase.camel(name) %>Queries} from './models/queries' 