import { spawn } from 'child_process'

const path = require('path')
const PrismaClientPath = path.join(
  process.cwd(),
  'node_modules/@prisma/client',
)

let dmmf
try {
  dmmf = require(PrismaClientPath).dmmf
} catch (e) {}
const dataModels = dmmf?.datamodel?.models ? dmmf.datamodel.models : []

export function generateModel(template, index) {
  const modelName = dataModels[index].name
  console.log(`\n## Start generating ${modelName} model. ##`)
  const gen = spawn(
    'psg',
    [template, '--name', modelName, '--noPrettier', 'true'],
    { stdio: 'inherit' },
  )

  gen.on('error', (error) => {
    console.log(`error: ${error.message}`)
  })

  gen.on('close', (code) => {
    console.log(`\n## Generating ${modelName} model is done. ##`)
    if (index < dataModels.length - 1) {
      index++
      generateModel(template, index)
    } else {
      if (template === 'model') {
        spawn('psg', ['inputs'], { stdio: 'inherit' })
      }
      spawn('npm', ['run', 'prettier'], { stdio: 'inherit' })
    }
  })
}
