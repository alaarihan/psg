---
to: <%= options.dir %>/models/enums.ts
force: true
---

import { GraphQLEnumType } from 'graphql'

export const SubscriptionOpernation = new GraphQLEnumType({
  name: 'SubscriptionOpernation',
  values: {
    CREATE: { value: 'CREATE' },
    UPDATE: { value: 'UPDATE' },
    DELETE: { value: 'DELETE' },
  },
})

<% Enums.forEach(function(Enum){ -%> 
export const <%= Enum.name %> = new GraphQLEnumType({
  name: '<%= Enum.name %>',
  values: {
    <% Enum.values.forEach(function(value){ -%>
    <%= value %>: { value: '<%- value %>' },
    <% }); %>
  }
});
<% }); %>
