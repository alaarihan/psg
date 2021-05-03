const { getGqlType, inputs, Enums, options } = require('../helpers')
module.exports = {
  params: ({ args }) => {
   
    return { ...args, inputs, Enums, getGqlType, options }
  },
}
