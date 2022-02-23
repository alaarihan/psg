const { getGqlType, inputs, Enums, options } = require('../helpers')
module.exports = {
  params: ({ args }) => {
    if (args.noPrettier === undefined) {
      args.noPrettier = false
    }
    return { ...args, inputs, Enums, getGqlType, options }
  },
}
