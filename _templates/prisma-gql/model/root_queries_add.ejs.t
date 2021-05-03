---
inject: true
to: <%= options.dir %>/schema.ts
after: "// merge the query fields here"
skip_if: "...<%= h.changeCase.camel(name) %>Queries"
---

...<%= h.changeCase.camel(name) %>Queries,