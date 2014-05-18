app = angular.module 'squelch'

app.controller "SidebarController", [ "$scope", "sidebar", ($scope, sidebar) ->
	$scope.sidebar = sidebar
]