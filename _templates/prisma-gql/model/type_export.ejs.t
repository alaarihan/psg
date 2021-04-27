---
inject: true
to: src/models/types.ts
append: true
skip_if: "'./<%= name %>/type'"
---

export * from './<%= name %>/type' 