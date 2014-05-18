app = angular.module "squelch"
app.value "squelchState", ->
	currentClient: null
	currentChannel: null