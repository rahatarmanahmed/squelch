app = angular.module "squelch"
app.factory "sidebar", ["$state", ($state) ->
	sections:
		servers: {}
		scripts: {}
		settings: {}
	treeData:
		servers: []
		scripts: []
		settings: []
	sectionOrder: ["servers", "scripts", "settings"]

	addServer: (name, id) ->
		branch = @sections.servers.add_root_branch
			label: name
			children: []
			noLeaf: true
			data: {id: id, channel: ""}
			onSelect: @serverListSelect
			classes: ["server"]
		@sections.servers.select_branch branch

	addChannel: (id, channel) ->
		server = @findServerBranch id
		branch = @sections.servers.add_branch server,
			label: channel
			data: {id, channel}
			onSelect: @serverListSelect
			classes: ["channel"]
		@sections.servers.select_branch branch

	# TODO: convert to using tree-control; needs fork of abn tree
	# removeChannel: (id, chan) ->
	# 	server = @findServer id
	# 	for chan, i in server.children
	# 		if label is chan
	# 			server.children.splice i, 1
	# 			break

	###
	@nodoc
	Uses tree control functions to find branch representing server
	###
	findServerBranch: (id) ->
		b = @sections.servers.get_first_branch()
		console.log b
		while b? and b.data.id isnt id
			b = @sections.servers.get_next_sibling b
		return b

	
	###
	@nodoc
	Uses tree control functions to find branch representing channel
	If channel is "" or omitted, will return server branch
	###
	findChannelBranch: (id, channel="") ->
		server = @findServerBranch id
		if channel = ""
			return server
		for child in server.children
			return child if child.data.channel is channel


	###
	opens corresponding view in main view
	If channel is "" or omitted, will select server status window
	###
	selectChannel: (id, channel="") ->
		b = @findChannelBranch id, channel
		@sections.server.select_branch b

	###
	@nodoc
	###
	serverListSelect: (b) -> 
		$state.go "channel", b.data
]
