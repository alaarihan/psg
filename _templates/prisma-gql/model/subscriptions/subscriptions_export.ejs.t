---
inject: true
to: <%= options.dir %>/models/subscriptions.ts
append: true
skip_if: "'./<%= name %>/subscriptions'"
---

export * from './<%= name %>/subscriptions'