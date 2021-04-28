const { dmmf } = require('@prisma/client')
const { getGqlType, inputs, Enums } = require('../helpers')
module.exports = {
  params: ({ args }) => {
   
    return { ...args, inputs, Enums, getGqlType }
  },
}
