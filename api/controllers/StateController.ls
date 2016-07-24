require! {
  bluebird: p
  leshdash: { keyBy, clone, wait, lazy, union, assign, omit, map, each, curry, times, keys, first }
}

module.exports = do
  sub: (req,res) ->
    res.json { test: true }
