const { dmmf } = require('@prisma/client')

module.exports = {
  inputs: dmmf.schema.inputObjectTypes.prisma, //.filter(item => item.name.startsWith(args.name))
  Enums: [
    ...dmmf.schema.enumTypes.model,
    ...dmmf.schema.enumTypes.prisma,
  ],
  getGqlType: function (field) {
    let fieldType
    if (field.type === 'String') {
      fieldType = 'GraphQLString'
    } else if (field.type === 'Int') {
      fieldType = 'GraphQLInt'
    } else if (field.type === 'Float') {
      fieldType = 'GraphQLFloat'
    } else if (field.type === 'Boolean') {
      fieldType = 'GraphQLBoolean'
    } else if (field.type === 'DateTime') {
      fieldType = 'GraphQLDateTime'
    }else if (field.type === 'Json') {
      fieldType = 'GraphQLJSON'
    } else {
      fieldType = field.type
    }
    // fieldType = field.location && field.location === 'inputObjectTypes' ? `${fieldType}()` : fieldType
    fieldType = field.isList ? `new GraphQLList(${fieldType})` : fieldType
    fieldType = field.isRequired
      ? `new GraphQLNonNull(${fieldType})`
      : fieldType
    return fieldType
  },

  getGqlTypeArgs(modelName, field){
    return dmmf.schema.outputObjectTypes.model.find(item => item.name === modelName).fields.find(item => item.name === field.name).args
  }
}
