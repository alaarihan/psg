const path = require('path')
const PrismaClientPath = path.join(process.cwd(), "node_modules/@prisma/client")

const { dmmf } = require(PrismaClientPath)
const { getGqlType, getGqlTypeArgs, inputs, Enums, outputTypes, options } = require('../helpers')
module.exports = {
  params: ({ args }) => {
    const model = dmmf.datamodel.models.find((item) => item.name === args.name)
    if (args.noPrettier === undefined) {
      args.noPrettier = false
    }
    // outputTypes = dmmf.schema.outputObjectTypes.model.find(item => item.name === args.name).fields.filter(item => item.outputType.isList)
    return { ...args, model, inputs, Enums, outputTypes, getGqlType, getGqlTypeArgs, options }
  },
}
