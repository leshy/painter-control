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

Job = ({id, job, name, state}) -> ``( <div> {id} {name} {state} </div> )``


Collection = ({name, ChildView})->

  ConnectedView = connect(    
    (state, props) -> elements: state[name]
    (dispatch, props) -> {}
    ) ({ elements }) ->
      children = map elements, (element) ->
        ``( <ChildView key={element.id} {...element} /> )``
      ``(
        <div className={style.elements}>
          { children }
        </div>
      )``
  
  ``(
    <div className={style.collection}>
      <div className={style.title}>
        { name }
      </div>
      <ConnectedView />
    </div>

  )``

module.exports = ->
  ``(
    <div className={style.root}>
      <div className={style.left}>
        <Collection name="workers" ChildView={Job} />
      </div>

      <div className={style.right}>
        <Collection name="jobs" ChildView={Job} />
      </div>
  
    </div>
  )``



