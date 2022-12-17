const { getHelpers } = require('../helpers')
module.exports = {
  params: async ({ args }) => {
    const helpers = await getHelpers()
    const { getGqlType, getGqlTypeArgs, inputs, Enums, outputTypes, options, dmmf } = helpers
    const model = dmmf.datamodel.models.find((item) => item.name === args.name)
    if (args.noPrettier === undefined) {
      args.noPrettier = false
    }
    // outputTypes = dmmf.schema.outputObjectTypes.model.find(item => item.name === args.name).fields.filter(item => item.outputType.isList)
    return { ...args, model, inputs, Enums, outputTypes, getGqlType, getGqlTypeArgs, options, models: dmmf.datamodel.models }
  },
}
