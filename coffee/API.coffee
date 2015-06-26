class @FacadeAPI
	constructor: (socketAdress, callback) ->
		@socket = new WebSocket(socketAdress)
		@nickname = @getCookie 'nickname'
		@token = @getCookie 'token'
		@rooms = []
		@isAuthorize ?= @token

		@types = [{
			type: 'auth_success',
			callbacks: [
					@onAuthorize
			]
		},
		{
			type: 'message',
			callbacks: [
			]
		},
		{
			type: 'users',
			callbacks: [
				@onUsers
			]
		},
		{
			type: 'rooms',
			callbacks: [
			]
		},
		{
			type: 'join',
			callbacks: [
					@onJoin
			]
		},
		{
			type: 'user_leave',
			callbacks: [
			]
		},
		{
			type: 'user_join',
			callbacks: [
			]
		},
		{
			type: 'error',
			callbacks: [
			]
		}
		]

		@socket.onerror = (e) =>
			@log e.type

		@socket.onclose = (e) =>
			@log e.reason

		@socket.onopen = =>
			do callback

		@socket.onmessage = (msg) =>
			data = JSON.parse(msg.data)
			for route in @types
				if route.type == data.type
					for func in route.callbacks
						func(data.data)
			return

#
# Public methods
#

	sendCommand: (type, data) ->
		@socket.send JSON.stringify {
			type: type,
			data
		}

# Auth and register

	authorize: (login, password) ->
		@sendCommand 'auth', {login: login, password: password}

	logout: () ->
		@token = null
		@nickname = null
		@isAuthorize = false

# Rooms

	join: (roomID) ->
		@sendCommand 'join', {room_id: roomID, token: @token}

	getRooms: (start, end) ->
		@sendCommand 'get_rooms', {
			start: start || 0,
			end: end || 0
		}

	exit: (roomID) ->
			@sendCommand 'exit', {room_id: roomID}

# Messages

	message: (roomID, message) ->
		if @isAuthorize
			@sendCommand 'message', {room_id: roomID, token: @token, message: message}

# Requests

	exit: (roomID) ->
		rooms.map (item) ->
			if item.id == roomID
				sendCommand 'exit', {room_id: roomID, token: @token}

	request: (roomID) ->
		if @isAuthorize
			@sendCommand 'request', {room_id: roomID, token: @token}

	getRequests: () ->
		if @isAuthorize
			@sendCommand 'get_requests', {token: @token}

	invite: (roomID, user) ->
		if @isAuthorize
			@sendCommand 'invite', {room_id: roomID, token: @token, user: user}

	confirm: (request) ->
		if @isAuthorize
			@sendCommand 'confirm', {request: request, token: @token}

	getUsers: (roomID) ->
			@sendCommand 'get_users', {room_id: roomID}

#
# Callbacks and events
#

	onAuthorize: (data) =>
		@nickname = data.nickname
		@token = data.token
		@isAuthorize = true
		
		document.cookie['token'] = data.token
		document.cookie['nickname'] = data.nickname

	onJoin: (data) =>
		@rooms.push data

	onUsers: (data) =>
		@rooms.map (item) ->
			if item.id == data.id
				item.users = data.users

	addListener: (type, callback) ->
		for route in @types
			if route.type == type
				route.callbacks.push callback
		return


#
# Private methods
#

	getCookie: (name) ->
		matches = document.cookie.match(new RegExp("(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"))
		return if matches then decodeURIComponent(matches[1]) else undefined;

	log: (msg) ->
		console.log("API facade - #{(new Date()).toTimeString()}: #{msg}")