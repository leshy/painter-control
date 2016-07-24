require! {
  leshdash: { assign, each, wait }
  bluebird: p
  'lweb3/transports/server/nssocket': { nssocketServer }
  'lweb3/protocols/query': query
}



module.exports = (sails) ->
  do
    initialize: (cb) ->
      server = new nssocketServer port: 4141
      server.addProtocol new query.serverServer()
      
      wait 1000, ->
        console.log 'remove workers'
        sails.models.worker.find {}, (err,workers) ->
          each workers, ->
            it.destroy()
            sails.models.worker.publishDestroy it.id

      server.on 'connect', (client) ->
        unsub = client.onQuery hi: true, (msg, reply, cleint) ->
          console.log 'worker connected', msg
          reply.end hi: msg.hi
          
          unsub()
          sails.models.worker.create name: msg.hi
          .then (worker) ->
            sails.models.worker.publishCreate worker
            
            client.on 'disconnect', ->
              sails.models.worker.publishDestroy worker.id
              worker.destroy!
          
      cb!
