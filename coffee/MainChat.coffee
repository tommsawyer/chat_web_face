ChatUsers = React.createClass
	componentDidMount: ->
		API.addListener('users', (data) =>
				@setState({users: data.users})
			)

	getInitialState: ->
		{users: []}
	
	render: ->
		React.createElement("div", {"className": 'users span1'},
			React.createElement("ul", {"className": 'nav nav-pills nav-stacked'},
				(@state.users.map (item) ->
					React.createElement("li", null, " ", (item.nickname), " ")
				)
			)
		)

ChatWindow = React.createClass
	getRoom: ->
		@props.room

	getInitialState: ->
		{messages: []}
	

	componentDidMount: ->
		API.addListener('message', (data) =>
				msg = @state.messages
				msg.push data
				@setState {messages: msg}
			)

		tarea = document.getElementById('msgtext')
		tarea.onkeydown = (e) =>
			if e.keyCode == 13
				API.message(@getRoom(), tarea.value)
				tarea.value = ''
				do e.preventDefault

	render: ->
		React.createElement("div", {"className": 'chat span10'},
			(
				@state.messages.map (item, i) =>
					React.createElement("span", null,
						React.createElement("span", {"className": 'user-info'}, " ", (item.nickname), " "), " : ", (item.message), "  ", React.createElement("br", null)
					)
			),
			React.createElement("textarea", {"id": 'msgtext', "className": "span10", "placeholder": "Ваше сообщение"})
		)

ChatTabs = React.createClass
	isActive: (num) ->
		if @props.active == num
			return 'active'
		return ''
	render: ->
		React.createElement("ul", {"className": "nav nav-tabs"},
			(@props.rooms.map (item, i) =>
				React.createElement("li", {"className": (@isActive(i+1)), "data-roomid": (item.id)},
					React.createElement("a", {"href": ""},
						React.createElement("b", null, (item.name)),
						React.createElement("button", {"className": "close"}, "\u00d7")
					)
				)
			)
		)

MainChat = React.createClass
	getActiveRoom: ->
		API.rooms[@state.active-1]
	componentWillMount: ->
		API.addListener('join', (data) =>
				@setState({rooms: API.rooms})
			)
		API.addListener('message', (data) =>
				msg = @state.messages
				for room, ind in API.rooms
					if data.room_id == room.id
						msg[ind].push data
				@setState({messages: msg})
			)
	getInitialState: ->
		{active: 1, rooms: API.rooms, users: [], messages: [[]]}
	render: ->
		React.createElement("div", {"className": 'tabbable'},
			React.createElement("div", {"className": "tab-content"},
				React.createElement(ChatTabs, {"active": (@state.active), "rooms": (@state.rooms)}),
				React.createElement(ChatWindow, {"messages": (@state.messages[@state.active - 1]), "room": (if API.rooms[@state.active-1]?
									API.rooms[@state.active-1].id) 
				}),
				React.createElement(ChatUsers, null)
			)
		)