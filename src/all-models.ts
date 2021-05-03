import { spawn } from "child_process"

const path = require('path')
const PrismaClientPatch = path.join(
  process.cwd(),
  'node_modules/@prisma/client',
)

const { dmmf } = require(PrismaClientPatch)
const dataModels = dmmf.datamodel.models

export function generateModel(index) {
  const modelName = dataModels[index].name
  console.log(`\n## Start generating ${modelName} model. ##`)
  const gen = spawn(
    'psg',
    ['model', '--name', modelName, '--noPrettier', 'true'],
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
