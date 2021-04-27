const { dmmf } = require('@prisma/client')
const { getGqlType, model, inputs,  Enums} = require('../helpers')
module.exports = {
  params: ({ args }) => {
    const model = dmmf.datamodel.models.find((item) => item.name === args.name)
    if (args.noPrettier === undefined) {
      args.noPrettier = false
    }
    return { ...args, model, inputs, Enums, getGqlType }
  },
}
