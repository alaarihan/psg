---
inject: true
to: <%= options.dir %>/schema.ts
after: "merge_the_query_fields_here"
skip_if: "...<%= h.changeCase.camel(name) %>Queries"
---

...<%= h.changeCase.camel(name) %>Queries,