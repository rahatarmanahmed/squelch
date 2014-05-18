app = angular.module 'squelch'

app.controller "ChannelController", [ "$scope", "$stateParams", "buffer", "clients", ($scope, $stateParams, buffer, clients) ->
	id = $stateParams.id
	channel = $stateParams.channel
	$scope.currentChannel = channel
	$scope.currentClient = clients.getClient id
	$scope.buffer = buffer.getBuffer id, channel
]