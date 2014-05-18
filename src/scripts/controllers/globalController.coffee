app = angular.module 'squelch'

app.controller "GlobalController", [ "$scope", "clients", ($scope, clients) ->
	clients.addClient
		server: "irc.esper.net"
		nick: "TestBot"
		channels: ["#kellyirctest", "#squelch"]
]