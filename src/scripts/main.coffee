app = angular.module 'squelch', ['ui.router', 'angularBootstrapNavTree', 'cfp.hotkeys']

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
.config ["hotkeysProvider", (hotkeysProvider) ->
	hotkeysProvider.includeCheatSheet = false;
	Mousetrap.stopCallback = (event, element, combo) ->
		if (' ' + element.className + ' ').indexOf(' mousetrap ') > -1
			return false
		# return element.tagName == 'INPUT' or element.tagName == 'SELECT' or element.tagName == 'TEXTAREA' or (element.contentEditable && element.contentEditable == 'true')
		return element.tagName == 'SELECT' or element.tagName == 'TEXTAREA' or (element.contentEditable && element.contentEditable == 'true')
]