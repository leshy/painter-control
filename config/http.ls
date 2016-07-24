        
module.exports =
#  http:
#    customMiddleware: (app) ->     
#      app.set 'json replacer', (name,data) ->
#        console.log name, data, data instanceof Date
#        if data instanceof Date then data.getTime()
#        else data
        
  paths:
    public: 'static/'

  http:
    middleware:
      order: [
          'startRequestTimer',
          'cookieParser',
          'session',
          'passport'
          'bodyParser',
          'handleBodyParserError',
          'compress',
          'methodOverride',
          '$custom',
          'router',
          'www',
          'favicon',
          '404',
          '500'
      ]

