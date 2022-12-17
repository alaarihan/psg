---
to: <%= name %>/.psg.js
unless_exists: true
---
const pluralize = require('pluralize');
const changeCase = require('change-case');
function toCamelCase(text) {
  return changeCase.camelCase(text)
}

module.exports.options = {
  dir: "src",
  queryMap: {
    findUnique(type) {
      return toCamelCase(type)
    },
    findFirst(type) {
      return toCamelCase(type) + 'First'
    },
    findMany(type) {
      return pluralize(toCamelCase(type))
    },
    count(type) {
      return pluralize(toCamelCase(type)) + 'Count'
    },
    aggregate(type) {
      return pluralize(toCamelCase(type)) + 'Aggregate'
    },
    createOne(type) {
      return 'create' + type
    },
    updateOne(type) {
      return 'update' + type
    },
    deleteOne(type) {
      return 'delete' + type
    },
    upsertOne(type) {
      return 'upsert' + type
    },
    createMany(type) {
      return 'create' + pluralize(type)
    },
    updateMany(type) {
      return 'update' + pluralize(type)
    },
    deleteMany(type) {
      return 'delete' + pluralize(type)
    },
    subscription(type) {
      return toCamelCase(type)
    },
  }
}

/*
You can use the default query names like this
module.exports.options = {
  dir: "src",
  queryMap: {
    findUnique(type) {
      return 'findUnique' + type
    },
    findFirst(type) {
      return 'findFirst' + type
    },
    findMany(type) {
      return 'findMany' + type
    },
    count(type) {
      return 'count' + type
    },
    aggregate(type) {
      return 'aggregate' + type
    },
    createOne(type) {
      return 'createOne' + type
    },
    updateOne(type) {
      return 'updateOne' + type
    },
    deleteOne(type) {
      return 'deleteOne' + type
    },
    upsertOne(type) {
      return 'upsertOne' + type
    },
    createMany(type) {
      return 'createMany' + type
    },
    updateMany(type) {
      return 'updateMany' + type
    },
    deleteMany(type) {
      return 'deleteMany' + type
    },
    subscription(type) {
      return toCamelCase(type)
    },
  }
}
*/
