app = angular.module 'squelch'

app.controller "ChannelController", [ "$scope", "$stateParams", "buffer", "clients", "squelchState", "input", ($scope, $stateParams, buffer, clients, squelchState, input) ->
	id = $stateParams.id
	channel = $stateParams.channel
	$scope.currentChannel = squelchState.currentChannel = channel
	$scope.currentClient = squelchState.currentClient = clients.getClient id
	$scope.buffer = buffer.getBuffer id, channel
	$scope.inputText = ""

	input.registerInputHotkey "enter", (event, hotkey) ->
		input.handleInput $scope.inputText
		$scope.inputText = ""


]