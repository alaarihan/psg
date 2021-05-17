
const options = require('../options')
module.exports = {
  params: ({ args }) => {
    return { ...args, options }
  },
}
