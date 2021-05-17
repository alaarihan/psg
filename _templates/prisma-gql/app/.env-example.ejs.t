---
to: <%= name %>/.env-example
---

APP_SECRET=<%= appName %>Secret

MAIL_FROM=<%= appName %> <<%= appName %>@gmail.com>
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=<%= appName %>@gmail.com
MAIL_PASSWORD=password
