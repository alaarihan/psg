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
import { GraphQLDateTime,  GraphQLJSON } from 'graphql-scalars'
<%_
const modelsToImport = model.fields.filter(field => field.kind === 'object')
let modelImports = modelsToImport && modelsToImport.length > 0 ? modelsToImport.map(item => item.type) : null
modelImports = [...new Set(modelImports)];
const enumsToImport = model.fields.filter(field => field.kind === 'enum')
let enumsImports = enumsToImport && enumsToImport.length > 0 ? enumsToImport.map(item => item.type) : []

const inputsToImport = model.fields.filter(field => field.kind === 'object' && field.isList )
let inputsImports = []
inputsToImport && inputsToImport.length > 0 ? inputsToImport.map(item => { inputsImports = [...inputsImports, ...[`${item.type}OrderByInput`, `${item.type}WhereInput`, `${item.type}WhereUniqueInput`]]; return item } ) : null
if(inputsToImport && inputsToImport.length){
  inputsToImport.map(item => { enumsImports.push(`${item.type}ScalarFieldEnum`); return item })
}
inputsImports = [...new Set(inputsImports)];
enumsImports = [...new Set(enumsImports)];
-%>
<%_ if(modelImports && modelImports.length > 0){ -%>
import { <%= modelImports.toString() %> } from '../types'
<%_ } -%>
<%_ if(enumsImports && enumsImports.length > 0){ -%>
import { <%= enumsImports.toString() %> } from '../enums'
<%_ } -%>
<%_ if(inputsImports && inputsImports.length > 0){ -%>
import { <%= inputsImports.toString() %> } from '../inputs'
<%_ } -%>

export const <%= name %> = new GraphQLObjectType({
  name: '<%= name %>',
  fields: () => ({
    <% model.fields.forEach(function(field){ -%>
    <%= field.name %>: { 
      type: <%- getGqlType(field) %>,
      <%_ if(field.kind === 'object' && field.isList === true){ -%>
        args: {
          <% getGqlTypeArgs(name, field).forEach(function(arg){ -%>
            <%= arg.name %>: { type: <%- getGqlType(arg.inputTypes[0]) %> },
          <% }) %>
        }
      <%_ } -%>
      },
    <% }) %>
  }),
})
