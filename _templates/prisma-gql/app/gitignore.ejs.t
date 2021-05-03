---
to: <%= name %>/.gitignore
unless_exists: true
---

node_modules
package-lock.json
dist
prisma/.env
src/models
