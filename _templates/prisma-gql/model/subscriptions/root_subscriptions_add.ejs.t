---
inject: true
to: <%= options.dir %>/schema.ts
after: "merge_the_subscription_fields_here"
skip_if: "...<%= h.changeCase.camel(name) %>Subscriptions"
---

...<%= h.changeCase.camel(name) %>Subscriptions,