minimist = require 'minimist'


minimistOption =
  string: 'env',
  default:
    env: process.env.NODE_ENV || 'development'

options = minimist(process.argv.slice(2), minimistOption)

isProduction = false
if(options.env == 'production')
  isProduction = true

console.log('[build env]', options.env, '[is production]', isProduction)


module.exports =
  isProduction: isProduction