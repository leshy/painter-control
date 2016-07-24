require! {
  # Helpers
  leshdash: { wait, union, assign, omit, map, curry, times, keys }
  bluebird: p

  moment

  # React
  react: React
  'react-dom'
  'react-router': { Router, Route, Redirect, IndexRedirect, browserHistory }
  classnames: cn

  # Redux
  redux
  redux: { createStore, combineReducers, applyMiddleware }
  'redux-thunk'

  'react-redux': { Provider, connect }
  'react-router-redux': { routerMiddleware, syncHistoryWithStore, routerReducer, push }

  # App
  './actions/index.ls': actions
  './reducers/index.ls': reducers
  './views/index.ls': views
  
  'react-addons-css-transition-group': Trans
}

store = createStore(
    combineReducers({
      ...reducers,
      routing: routerReducer
    })

    {}, # reducers will build this during @@INIT event

    applyMiddleware(
      reduxThunk.default,
      routerMiddleware(browserHistory)
    ) << if window.devToolsExtension then window.devToolsExtension() else -> it
)

history = syncHistoryWithStore browserHistory, store
io = require('sails.io.js')( require('socket.io-client') )

io.socket.on 'connect' -> console.log 'connected'



App = ->
  ``(
    <div>
      react initialized
    </div>
  )``

console.log 'reactdom render!'
reactDom.render App(), document.getElementById('app')

