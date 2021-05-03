---
inject: true
to: <%= options.dir %>/schema.ts
after: "// merge the mutation fields here"
skip_if: "...<%= h.changeCase.camel(name) %>Mutations"
---

...<%= h.changeCase.camel(name) %>Mutations,