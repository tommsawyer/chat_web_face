Auth = React.createClass
	componentDidMount: ->
		document.getElementById('send').onclick  = (e) =>
			API.authorize(document.getElementById('login').value, document.getElementById('password').value)
			@forceUpdate()
			e.preventDefault()
	render: ->
		React.createElement("div", null,
			React.createElement("form", null,
				React.createElement("div", {"className": "form-group"},
					React.createElement("label", {"for": "login"}, "\u041b\u043e\u0433\u0438\u043d"),
					React.createElement("input", {"type": "text", "className": "form-control", "id": "login", "placeholder": "Введите логин"})
				),
				React.createElement("div", {"className": "form-group"},
					React.createElement("label", {"for": "password"}, "\u041f\u0430\u0440\u043e\u043b\u044c"),
					React.createElement("input", {"type": "password", "className": "form-control", "id": "password", "placeholder": "Пароль"})
				),
				React.createElement("button", {"type": "submit", "id": "send", "className": "btn btn-inverse"}, "\u0412\u043e\u0439\u0442\u0438")
			)
		)
