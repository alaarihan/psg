#!/usr/bin/env node
const path = require('path')
const PrismaClientPatch = path.join(
  process.cwd(),
  'node_modules/@prisma/client',
)
let dmmf
try {
  dmmf = require(PrismaClientPatch).dmmf
} catch (e) {}
const { run } = require('../dist')
const { generateModel } = require('../dist/all-models')
const hygenArgs = ['prisma-gql', ...process.argv.slice(2)]
if (
  process.argv &&
  process.argv.length > 3 &&
  process.argv[2] === 'model' &&
  process.argv[3] === 'all' &&
  dmmf
) {
  generateModel(0)
} else {
  run(hygenArgs)
    .then(({ success }) => process.exit(success ? 0 : 1))
    .catch((error) => {
      console.error(error)
      process.exit(1)
    })
}