ChatUsers = React.createClass
	componentDidMount: ->
		API.addListener('users', (data) =>
				@setState({users: data.users})
			)

	getInitialState: ->
		{users: []}
	
	render: ->
		<div className='users span1'>
			<ul className='nav nav-pills nav-stacked'>
				{@state.users.map (item) ->
					<li> {item.nickname} </li>
				}
			</ul>
		</div>

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
		<div className='chat span10'>
			{
				@state.messages.map (item, i) =>
					<span>
						<span className='user-info'> {item.nickname} </span> : {item.message}  <br />
					</span>
			}
			<textarea id='msgtext' className="span10" placeholder="Ваше сообщение"></textarea>
		</div>

ChatTabs = React.createClass
	isActive: (num) ->
		if @props.active == num
			return 'active'
		return ''
	render: ->
		<ul className="nav nav-tabs">
			{@props.rooms.map (item, i) =>
				<li className={@isActive(i+1)} data-roomid={item.id}>
					<a href="">
						<b>{item.name}</b>
						<button className="close">&times;</button>
					</a>
				</li>
			}
		</ul>

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
		<div className='tabbable'>
			<div className="tab-content">
				<ChatTabs active={@state.active} rooms={@state.rooms} />
				<ChatWindow messages={@state.messages[@state.active - 1]} room={if API.rooms[@state.active-1]?
									API.rooms[@state.active-1].id} 
				/>
				<ChatUsers />
			</div>
		</div>