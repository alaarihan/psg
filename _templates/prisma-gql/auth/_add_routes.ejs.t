---
inject: true
to: <%= options.dir %>/server.ts
before: "await app.ready()"
skip_if: "./auth/auth/routes"
---

app.register(require('./auth/auth/routes'))
