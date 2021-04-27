const { dmmf } = require('@prisma/client')
const { getGqlType } = require('../helpers')
module.exports = {
  params: ({ args }) => {
    const inputs = dmmf.schema.inputObjectTypes.prisma //.filter(item => item.name.startsWith(args.name))
    const Enums = [
      ...dmmf.schema.enumTypes.model,
      ...dmmf.schema.enumTypes.prisma.filter((item) =>
        ['SortOrder', 'QueryMode'].includes(item.name),
      ),
    ]
    return { ...args, inputs, Enums, getGqlType }
  },
}
