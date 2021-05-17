const path = require('path')
const PrismaClientPatch = path.join(process.cwd(), "node_modules/@prisma/client")

const { dmmf } = require(PrismaClientPatch)
const { options } = require('../helpers')
module.exports = {
  params: ({ args }) => {
    return { ...args, options }
  },
}
