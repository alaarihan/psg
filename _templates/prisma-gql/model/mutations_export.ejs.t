---
inject: true
to: <%= options.dir %>/models/mutations.ts
append: true
skip_if: "'./<%= name %>/mutations'"
---

export * from './<%= name %>/mutations'