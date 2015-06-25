API = new FacadeAPI 'ws://localhost:8090', ->
	API.addListener 'error', (data) ->
		alert(data.error_descr)
		
	API.addListener 'join', (data) ->
		rendered.setActive(1)

	API.addListener 'auth_success', (data) ->
		alert("Успешно вошли как #{data.nickname}")
		rendered.setActive(1)

	Chat = React.createClass
		setActive: (num) ->
			@setState {tab: num}
		getInitialState: ->
			{tab: 1}
		getElement: (num) ->
			switch num
				when 1 then return <MainChat />
				when 2 then return <Rooms />
				when 3 then return <Orders />
				when 4 then return <Auth />
		render: ->
			<div className='container'>
				<Menu tab=@state.tab />
				{@getElement(@state.tab)}
			</div>

	rendered = React.render <Chat />, document.getElementById('chat'), ->
		document.getElementById('buttons').onclick =  (e) ->
			number = e.target.getAttribute 'data-num'
			if number 
				rendered.setActive(+number)
			return false;
			e.preventDefault()