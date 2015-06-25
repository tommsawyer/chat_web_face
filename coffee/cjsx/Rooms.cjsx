Rooms = React.createClass
	getInitialState: ->
		{rooms: []}
	
	componentDidMount: ->
		API.addListener('rooms', (data) => 
				@setState({rooms: data.rooms})
			)

		API.getRooms()

		document.getElementById('reload').onclick = ->
			API.getRooms()

		document.getElementById('addRoomBtn').onclick = ->
			addRoomForm = document.getElementById('addRoom')

			if addRoomForm.style.display == 'none'
				addRoomForm.style.display = 'block'
			else
				addRoomForm.style.display = 'none'

		document.getElementById('rooms-table').onclick = (e) ->
			roomID = e.target.getAttribute('data-roomid')
			if roomID
				API.join(+roomID)

	render: ->
		<div>
			<div className="row">
				<button className="btn btn-inverse span2" id="addRoomBtn">Добавить</button>
				<div className="addRoom span3" id="addRoom">
					<label for="room-name">Название комнаты</label>
					<input type="text" id="room-name"/>

					<label for="room-type">Тип комнаты</label>
					<select name="roomType" id="room-type">
						<option value="1">Открытая</option>
						<option value="2">Закрытая(с запросом)</option>
						<option value="3">Только по приглашениям</option>
					</select>

					<button className="btn btn-inverse" id="createRoom" >Добавить</button>
				</div>
				<button className="btn btn-inverse span2" id="reload">Обновить</button>
				<input className="span8 pull-right" type="text" placeholder="Фильтр..."/>
			</div>

			<table className="table table-hover" id="rooms-table">
				<tbody>
					<tr>
						<th className="span6">Название комнаты</th>
						<th className="span2">Тип комнаты</th>
						<th className="span2">Создатель</th>
						<th className="span2" colSpan="2">Количество участников</th>
					</tr>
					{
						@state.rooms.map (item) ->
							<tr>
								<td>{item.name}</td>
								<td>{item.type}</td>
								<td>{item.creator}</td>
								<td>{item.number}</td>
								<td>
									<button data-roomid={item.room_id} className="btn btn-inverse pull-right enterroom">Войти</button>
								</td>
							</tr>
					}
				</tbody>
			</table>
		</div>