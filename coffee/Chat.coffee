API = new FacadeAPI 'ws://localhost:8090', ->
	API.addListener 'error', (data) ->
		alert(data.error_descr)
	API.addListener 'join', (data) ->
		rendered.setActive(1)
	API.addListener 'auth_success', (data) ->
		alert("Успешно вошли как #{data.nickname}")
		rendered.forceUpdate()
		rendered.setActive(1)

	Chat = React.createClass
		setActive: (num) ->
			@setState {tab: num}
		getInitialState: ->
			{tab: 1}
		getElement: (num) ->
			switch num
				when 1 then return React.createElement(MainChat, null)
				when 2 then return React.createElement(Rooms, null)
				when 3 then return React.createElement(Orders, null)
				when 4 then return React.createElement(Auth, null)
		render: ->
			React.createElement("div", {"className": 'container'},
				React.createElement(Menu, {"tab": @state.tab}),
				(@getElement(@state.tab))
			)

	rendered = React.render React.createElement(Chat, null), document.getElementById('chat'), ->
		document.getElementById('buttons').onclick =  (e) ->
			number = e.target.getAttribute 'data-num'
			if number 
				rendered.setActive(+number)
			return false;
			e.preventDefault()