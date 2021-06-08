---
inject: true
to: <%= options.dir %>/server.ts
after: "add_middlewares"
skip_if: "jwtAuth,"
---

jwtAuth,
acl,
