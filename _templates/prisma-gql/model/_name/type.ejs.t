---
to: src/models/<%= name %>/type.ts
force: true
sh: "<%= !noPrettier ? `npm run prettier` : '' %>"
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
  GraphQLSchema
} from 'graphql'
import { GraphQLDateTime } from 'graphql-scalars'
<%_
const modelsToImport = model.fields.filter(field => field.kind === 'object')
let modelImports = modelsToImport && modelsToImport.length > 0 ? modelsToImport.map(item => item.type) : null
modelImports = [...new Set(modelImports)];
const enumsToImport = model.fields.filter(field => field.kind === 'enum')
let enumsImports = enumsToImport && enumsToImport.length > 0 ? enumsToImport.map(item => item.type) : null
enumsImports = [...new Set(enumsImports)];
-%>
<%_ if(modelImports && modelImports.length > 0){ -%>
import { <%= modelImports.toString() %> } from '../types'
<%_ } -%>
<%_ if(enumsImports && enumsImports.length > 0){ -%>
import { <%= enumsImports.toString() %> } from '../enums'
<%_ } -%>

export const <%= name %> = new GraphQLObjectType({
  name: '<%= name %>',
  fields: () => ({
    <% model.fields.forEach(function(field){ -%>
    <%= field.name %>: { type: <%- getGqlType(field) %> },
    <% }) %>
  }),
})
