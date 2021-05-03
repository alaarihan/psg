const path = require('path')
const PrismaClientPatch = path.join(
  process.cwd(),
  'node_modules/@prisma/client',
)
console.log('options')
const generatorOptionsFile = path.join(process.cwd(), '.psg.js')
let options = { dir: 'app'}
try {
  const generatorOptions = require(generatorOptionsFile)
  options = generatorOptions.options
} catch (e) {
  if (e instanceof Error && e.code === 'MODULE_NOT_FOUND') {
    console.log("Can't find .psg.js file")
  } else throw e
}
if(!options.dir){
  options.dir = 'app'
}

const { dmmf } = require(PrismaClientPatch)

module.exports = {
  options,
  inputs: dmmf.schema.inputObjectTypes.prisma, //.filter(item => item.name.startsWith(args.name))
  Enums: dmmf.schema.enumTypes.model
    ? [...dmmf.schema.enumTypes.model, ...dmmf.schema.enumTypes.prisma]
    : dmmf.schema.enumTypes.prisma,
  getGqlType: function (item) {
    let field
    if (item.inputTypes && item.inputTypes.length) {
      let newField
      if (
        item.inputTypes.length > 1 &&
        item.inputTypes[1].type.endsWith('FieldUpdateOperationsInput')
      ) {
        newField = item.inputTypes[0]
      } else if (
        item.inputTypes.length > 1 &&
        (item.inputTypes[1].location === 'inputObjectTypes' ||
          item.inputTypes[1].isList)
      ) {
        newField = item.inputTypes[1]
      } else {
        newField = item.inputTypes[0]
      }
      field = newField
      field.isRequired =
        item.isRequired !== undefined ? item.isRequired : undefined
      field.isNullable =
        item.isNullable !== undefined ? item.isNullable : undefined
    } else {
      field = item
    }
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
    } else if (field.type === 'Json') {
      fieldType = 'GraphQLJSON'
    } else {
      fieldType = field.type
    }
    fieldType =
      field.isList &&
      (field.isNullable === false ||
        (field.isNullable === undefined && field.isRequired))
        ? `new GraphQLNonNull(${fieldType})`
        : fieldType
    fieldType = field.isList ? `new GraphQLList(${fieldType})` : fieldType
    fieldType = field.isRequired
      ? `new GraphQLNonNull(${fieldType})`
      : fieldType
    return fieldType
  },

  getGqlTypeArgs(modelName, field) {
    return dmmf.schema.outputObjectTypes.model
      .find((item) => item.name === modelName)
      .fields.find((item) => item.name === field.name).args
  },
}
