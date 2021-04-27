const { spawn } = require('child_process')
const { dmmf } = require('@prisma/client')
const dataModels = dmmf.datamodel.models

function generateModel(index) {
  const modelName = dataModels[index].name
  console.log(`\n## Start generating ${modelName} model. ##`)
  const gen = spawn(
    'hygen',
    ['prisma-gql', 'model', '--name', modelName, '--noPrettier', 'true'],
    { stdio: 'inherit' },
  )

  gen.on('error', (error) => {
    console.log(`error: ${error.message}`)
  })

  gen.on('close', (code) => {
    console.log(`\n## Generating ${modelName} model is done. ##`)
    if (index < dataModels.length - 1) {
      index++
      generateModel(index)
    } else {
      spawn('npm', ['run', 'prettier'], { stdio: 'inherit' })
    }
  })
}
generateModel(0)
