const { getHelpers } = require('../helpers')


module.exports = {
  params: async ({ args }) => {
    const helpers = await getHelpers()
    const { getGqlType, inputs, Enums, options } = helpers
    if (args.noPrettier === undefined) {
      args.noPrettier = false
    }
    return { ...args, inputs, Enums, getGqlType, options }
  },
}
