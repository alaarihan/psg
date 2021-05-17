---
inject: true
to: <%= options.dir %>/server.ts
before: "await app.ready()"
skip_if: "./auth/src/routes"
---

app.register(require('./auth/src/routes'))
