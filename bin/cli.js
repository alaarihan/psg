#!/usr/bin/env node

const { run } = require('../dist')
const hygenArgs = ['prisma-gql', ...process.argv.slice(2)]
if (
  process.argv &&
  process.argv.length > 3 &&
  process.argv[2].startsWith('model') &&
  process.argv[3] === 'all'
) {
  // generate all models
  const { generateModel } = require('../dist/all-models')
  generateModel(process.argv[2], 0)
} else {
  run(hygenArgs)
    .then(({ success }) => process.exit(success ? 0 : 1))
    .catch((error) => {
      console.error(error)
      process.exit(1)
    })
}
