---
to: src/models/enums.ts
force: true
---

import { GraphQLEnumType } from 'graphql'

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
