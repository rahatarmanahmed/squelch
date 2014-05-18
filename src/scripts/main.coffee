app = angular.module 'squelch', ['ui.router', 'angularBootstrapNavTree']

app.config ["$stateProvider", ($stateProvider) ->
	$stateProvider
		.state "index",
			url: "/"
			views:
				"main-view":
					templateUrl: "partials/firstTimeView.html"
		# .state "client",
		# 	url: "/client/:id"
		# 	views:
		# 		"main-view":
		# 			templateUrl: "partials/clientView.html"
		# 			controller: "ClientController"
		.state "channel",
			url: "/client/:id/:channel"
			views:
				"main-view":
					templateUrl: "partials/channelView.html"
					controller: "ChannelController"
]