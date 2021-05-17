
const path = require('path')
const generatorOptionsFile = path.join(process.cwd(), '.psg.js')
let options = { dir: 'src'}
try {
  const generatorOptions = require(generatorOptionsFile)
  options = generatorOptions.options
} catch (e) {
}
if(!options.dir){
  options.dir = 'src'
}

module.exports = options

