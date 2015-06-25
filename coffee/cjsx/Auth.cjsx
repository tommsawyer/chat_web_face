Auth = React.createClass
	componentDidMount: ->
		document.getElementById('send').onclick  = (e) =>
			API.authorize(document.getElementById('login').value, document.getElementById('password').value)
			@forceUpdate()
			e.preventDefault()
	render: ->
		<div>
			<form>
				<div className="form-group">
					<label for="login">Логин</label>
					<input type="text" className="form-control" id="login" placeholder="Введите логин" />
				</div>
				<div className="form-group">
					<label for="password">Пароль</label>
					<input type="password" className="form-control" id="password" placeholder="Пароль" />
				</div>
				<button type="submit" id="send" className="btn btn-inverse">Войти</button>
			</form>
		</div>
