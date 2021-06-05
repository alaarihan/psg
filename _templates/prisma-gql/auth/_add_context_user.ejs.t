---
inject: true
to: <%= options.dir %>/context.ts
after: "add_context_items"
skip_if: "user: await getUserFromCookies"
---

user: await getUserFromCookies(req, reply),
