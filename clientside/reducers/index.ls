require! {
  leshdash: { assign, omit }
}

crud = (name) ->
  (state={}, action) ->
    switch action.type
      | '@@INIT' => state
      | "#{name}_add" => assign { "#{action.data.id}": action.data }, state
      | "#{name}_remove" => omit state, action.data.id
      | "#{name}_update" => assign {}, state, { "#{action.data.id}": assign action.data.update, state[action.data.id] }
      | otherwise => state
  
module.exports =
  jobs: crud 'jobs'
  workers: crud 'workers'
