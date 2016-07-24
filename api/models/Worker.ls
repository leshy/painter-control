module.exports = do
  attributes:
    name:
      required: true
      
    jobs:
      collection: 'job'
      via: 'worker'

