Client = require 'node-irc-client'

app = angular.module "squelch"
app.factory "clients", ["$timeout", "sidebar", "buffer", ($timeout, sidebar, buffer) ->
	clients: []
	addClient: (opt) ->
		client = new Client opt
		@clients.push client
		client.id = @clients.length-1
		# use timeout so tree-data has a chance to instantiate
		$timeout ->
			sidebar.addServer opt.name || opt.server, client.id

		# TODO: proper output handling
		client.on 'join', safe (chan) ->
			sidebar.addChannel client.id, chan
			buffer.append client.id, chan, "You have joined #{chan}."
		client.on 'raw', safe (reply) ->
			if reply? and reply.command?
				msg = reply.command + " " + reply.params.join " "
				buffer.append client.id, "", msg if msg.trim() isnt ""
		client.on 'msg', safe (from, to, msg) ->
			if client.isChannel to
				buffer.append client.id, to, "<#{from}> #{msg}"

		return client.id

	getClient: (id) -> @clients[id]
]

# TODO: integrate this into an event system
#		but make it nice idk
# Totally NOT safe.
safe = (fn) ->
	return (args...) ->
		try
			fn args...
		catch e
			console.error e.stack