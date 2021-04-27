const { dmmf } = require('@prisma/client')

module.exports = {
  inputs: dmmf.schema.inputObjectTypes.prisma, //.filter(item => item.name.startsWith(args.name))
  Enums: [
    ...dmmf.schema.enumTypes.model,
    ...dmmf.schema.enumTypes.prisma.filter((item) =>
      ['SortOrder', 'QueryMode'].includes(item.name),
    ),
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
}
