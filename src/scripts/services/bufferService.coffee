app = angular.module "squelch"
app.factory "buffer", ["$rootScope", ($rootScope) ->
	buffer: {}
	###
	Append a message to the buffer of a client's channel.
	If channel is empty string, then it represents the
	client's status window buffer.
	###
	append: (clientID, channel, message) ->
		@buffer[clientID] = {} if not @buffer[clientID]?
		@buffer[clientID][channel] = [] if not @buffer[clientID][channel]?
		@buffer[clientID][channel].push
			message: message
			time: Date.now()
		$rootScope.$apply()

	###
	Returns array of chosen buffer. If channel is not given,
	will return buffer of client's status window.
	###
	getBuffer: (clientID, channel="") -> 
		@buffer[clientID] = {} if not @buffer[clientID]?
		@buffer[clientID][channel] = [] if not @buffer[clientID][channel]?
		@buffer[clientID][channel]
]