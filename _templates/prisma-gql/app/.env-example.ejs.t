---
to: <%= name %>/.env-example
---

API_SECRET=<%= appName %>Secret
ADMIN_SECRET=<%= appName %>AdminSecret
DATABASE_URL=postgres://username:password@host:5432/db_name?connection_limit=20

API_URL=http://localhost:3000

MAIL_FROM=<%= appName %> <<%= appName %>@gmail.com>
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=<%= appName %>@gmail.com
MAIL_PASSWORD=password
