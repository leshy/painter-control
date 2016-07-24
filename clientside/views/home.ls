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


Jobs = connect(    
  (state, props) -> jobs: state.jobs
  (dispatch, props) -> {}
  ) ({ jobs }) ->
    
    elements = map jobs, (job) -> ``( <div key={job.id} > {job.id} {job.name} {job.state} </div> )``
    
    ``(
      <Collection name="Jobs">
        { elements }
      </Collection>

    )``


Workers = connect(    
  (state, props) -> workers: state.workers
  (dispatch, props) -> {}
  ) ({ workers }) ->
    
    elements = map workers, (worker) -> ``( <div key={worker.id} > {worker.id} </div> )``
    
    ``(
      <Collection name="Workers">
        { elements }
      </Collection>

    )``



Collection = ({name, children})->
  ``(
    <div className={style.collection}>
      <div className={style.title}>
        { name }
      </div>
      <div className={style.elements}>
        { children }
      </div>
    </div>

  )``

module.exports = ->
  ``(
    <div className={style.root}>
      <div className={style.left}>
        <Workers />
      </div>

      <div className={style.right}>
        <Jobs />
      </div>
  
    </div>
  )``



