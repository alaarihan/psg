---
to: <%= name %>/.env-example
---

JWT_SECRET=<%= appName %>Secret
ROOT_SECRET=<%= appName %>RootSecret
UNAUTHORIZED_ROLE=UNAUTHORIZED
DATABASE_URL=postgres://username:password@host:5432/db_name?connection_limit=20

API_URL=http://localhost:3000

MAIL_FROM=<%= appName %> <<%= appName %>@gmail.com>
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=<%= appName %>@gmail.com
MAIL_PASSWORD=password
