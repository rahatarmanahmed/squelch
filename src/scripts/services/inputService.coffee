app = angular.module "squelch"
app.factory "input", ["hotkeys", "squelchState", "buffer", (hotkeys, squelchState, buffer) ->
	handleInput: (text) ->
		if text[0] is '/'
			@handleCommand text[1..]
		else
			if squelchState.currentChannel is ""
				buffer.append squelchState.currentClient.id, squelchState.currentChannel,
					"Cannot send message to status window!"
			else
				squelchState.currentClient.msg squelchState.currentChannel, text
				buffer.append squelchState.currentClient.id, squelchState.currentChannel,
					"<#{squelchState.currentClient.nick()}> #{text}"

	handleCommand: (command) ->
		# TODO: make a command handler service?

	registerInputHotkey: (hotkey, cb) ->
		hotkeys.add 
			combo: hotkey
			description: "Descriptions are for suckers."
			allowIn: ["INPUT"]
			callback: (event, hotkey) ->
				if event.target.id is "input-box"
					cb event, hotkey
]
