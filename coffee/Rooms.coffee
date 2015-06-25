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
		React.createElement("div", null,
			React.createElement("div", {"className": "row"},
				React.createElement("button", {"className": "btn btn-inverse span2", "id": "addRoomBtn"}, "\u0414\u043e\u0431\u0430\u0432\u0438\u0442\u044c"),
				React.createElement("div", {"className": "addRoom span3", "id": "addRoom"},
					React.createElement("label", {"for": "room-name"}, "\u041d\u0430\u0437\u0432\u0430\u043d\u0438\u0435 \u043a\u043e\u043c\u043d\u0430\u0442\u044b"),
					React.createElement("input", {"type": "text", "id": "room-name"}),

					React.createElement("label", {"for": "room-type"}, "\u0422\u0438\u043f \u043a\u043e\u043c\u043d\u0430\u0442\u044b"),
					React.createElement("select", {"name": "roomType", "id": "room-type"},
						React.createElement("option", {"value": "1"}, "\u041e\u0442\u043a\u0440\u044b\u0442\u0430\u044f"),
						React.createElement("option", {"value": "2"}, "\u0417\u0430\u043a\u0440\u044b\u0442\u0430\u044f(\u0441 \u0437\u0430\u043f\u0440\u043e\u0441\u043e\u043c)"),
						React.createElement("option", {"value": "3"}, "\u0422\u043e\u043b\u044c\u043a\u043e \u043f\u043e \u043f\u0440\u0438\u0433\u043b\u0430\u0448\u0435\u043d\u0438\u044f\u043c")
					),

					React.createElement("button", {"className": "btn btn-inverse", "id": "createRoom"}, "\u0414\u043e\u0431\u0430\u0432\u0438\u0442\u044c")
				),
				React.createElement("button", {"className": "btn btn-inverse span2", "id": "reload"}, "\u041e\u0431\u043d\u043e\u0432\u0438\u0442\u044c"),
				React.createElement("input", {"className": "span8 pull-right", "type": "text", "placeholder": "Фильтр..."})
			),

			React.createElement("table", {"className": "table table-hover", "id": "rooms-table"},
				React.createElement("tbody", null,
					React.createElement("tr", null,
						React.createElement("th", {"className": "span6"}, "\u041d\u0430\u0437\u0432\u0430\u043d\u0438\u0435 \u043a\u043e\u043c\u043d\u0430\u0442\u044b"),
						React.createElement("th", {"className": "span2"}, "\u0422\u0438\u043f \u043a\u043e\u043c\u043d\u0430\u0442\u044b"),
						React.createElement("th", {"className": "span2"}, "\u0421\u043e\u0437\u0434\u0430\u0442\u0435\u043b\u044c"),
						React.createElement("th", {"className": "span2", "colSpan": "2"}, "\u041a\u043e\u043b\u0438\u0447\u0435\u0441\u0442\u0432\u043e \u0443\u0447\u0430\u0441\u0442\u043d\u0438\u043a\u043e\u0432")
					),
					(
						@state.rooms.map (item) ->
							React.createElement("tr", null,
								React.createElement("td", null, (item.name)),
								React.createElement("td", null, (item.type)),
								React.createElement("td", null, (item.creator)),
								React.createElement("td", null, (item.number)),
								React.createElement("td", null,
									React.createElement("button", {"data-roomid": (item.room_id), "className": "btn btn-inverse pull-right enterroom"}, "\u0412\u043e\u0439\u0442\u0438")
								)
							)
					)
				)
			)
		)