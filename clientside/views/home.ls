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
  './index.ls': views
  
  'react-addons-css-transition-group': Trans

  './home.css': style
}

module.exports = ->
  ``(
    <div className={style.root}>
      <div className={style.left}>
        <div className={style.title}>
          Workers
        </div>
      </div>

      <div className={style.right}>
        <div className={style.title}>
          Jobs
        </div>
      </div>
  
    </div>
  )``



