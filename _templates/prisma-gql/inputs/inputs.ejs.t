---
to: <%= options.dir %>/models/inputs.ts
force: true
sh: "<%= !noPrettier ? `npm run prettier` : '' %>"
---

import {
  GraphQLString,
  GraphQLInt,
  GraphQLBoolean,
  GraphQLFloat,
  GraphQLList,
  GraphQLNonNull,
  GraphQLInputObjectType,
} from 'graphql'
import { GraphQLDateTime, GraphQLJSON } from 'graphql-scalars';
<% const importEnums = Enums.map(item => item.name) %>
import { <%= importEnums.toString() %> } from './enums'

export const SimpleStringFilter = new GraphQLInputObjectType({
  name: 'SimpleStringFilter',
  fields: () => ({
    equals: {
      type: GraphQLString,
    },
    in: {
      type: new GraphQLList(new GraphQLNonNull(GraphQLString)),
    },
    notIn: {
      type: new GraphQLList(new GraphQLNonNull(GraphQLString)),
    },
  }),
})

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
