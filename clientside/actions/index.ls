crud = (name) ->
  do
    add: -> type: "#{name}_add", data: it
    remove: -> type: "#{name}_remove", data: it
    update: -> type: "#{name}_update", data: it
    
  
module.exports = do
  worker: crud 'worker'
  job: crud 'job'
