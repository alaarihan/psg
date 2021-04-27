---
inject: true
to: src/schema.ts
after: fields
skip_if: "...<%= h.changeCase.camel(name) %>Queries"
---

...<%= h.changeCase.camel(name) %>Queries,