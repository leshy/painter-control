require! {
  bluebird: p
  leshdash: { keyBy, clone, wait, lazy, union, assign, omit, map, each, curry, times, keys, first }
}

render = (res, view) ->
  res.locals.version = sails.config.version
  res.locals.environment = sails.config.environment
  res.view view

module.exports = do
  redirect: (req,res) -> res.redirect('/')
  index: (req,res) -> render res, 'index'
