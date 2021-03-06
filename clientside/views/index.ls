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
  '../actions/index.ls': actions
  '../reducers/index.ls': reducers
  
  'react-addons-css-transition-group': Trans
}

module.exports = do
  home: require './home.ls'
  jobs: require './jobs.ls'
