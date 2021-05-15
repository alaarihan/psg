---
to: <%= name %>/.env-example
---

DATABASE_URL=postgres://username:password@host:5432/db_name?connection_limit=20

APP_SECRET=<%= appName %>Secret

MAIL_FROM=<%= appName %> <<%= appName %>@gmail.com>
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=<%= appName %>@gmail.com
MAIL_PASSWORD=password
