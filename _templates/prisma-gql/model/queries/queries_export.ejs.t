---
inject: true
to: <%= options.dir %>/models/queries.ts
append: true
skip_if: "'./<%= name %>/queries'"
---

export * from './<%= name %>/queries'