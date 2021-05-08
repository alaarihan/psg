---
inject: true
to: <%= options.dir %>/schema.ts
after: "merge_the_mutation_fields_here"
skip_if: "...<%= h.changeCase.camel(name) %>Mutations"
---

...<%= h.changeCase.camel(name) %>Mutations,