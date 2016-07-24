require! {
  leshdash: { assign }
  bluebird: p
  'lweb3/transports/server/nssocket': { nssocketServer }
  'lweb3/protocols/query': query
}



module.exports = (sails) ->
  do
    initialize: (cb) ->
      server = new nssocketServer port: 4141
      server.addProtocol new query.serverServer()
      
      server.on 'connect', (client) ->
        unsub = client.onQuery hi: true, (msg, reply, cleint) ->
          console.log 'worker connected', msg
          reply.end hi: msg.hi
          unsub()
        
      cb!
