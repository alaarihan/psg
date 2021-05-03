---
to: <%= options.dir %>/models/inputs.ts
force: true
---

import {
  GraphQLString,
  GraphQLID,
  GraphQLInt,
  GraphQLBoolean,
  GraphQLFloat,
  GraphQLList,
  GraphQLNonNull,
  GraphQLObjectType,
  GraphQLInputObjectType,
  GraphQLInputType,
  GraphQLSchema
} from 'graphql'
import { GraphQLDateTime, GraphQLJSON } from 'graphql-scalars';
<% const importEnums = Enums.map(item => item.name) %>
import { <%= importEnums.toString() %> } from './enums'

<% inputs.forEach(function(input){ -%> 
export const <%= input.name %> = new GraphQLInputObjectType({
  name: '<%= input.name %>',
  fields:  () => ({
    <% input.fields.forEach(function(field){ -%>
    <%= field.name %>: { type: <%- getGqlType(field) %> },
    <% }); %>
  })
});
<% }); %>
