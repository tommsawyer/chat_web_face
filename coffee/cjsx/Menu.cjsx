Menu = React.createClass
	isActive: (num) ->
		if @props.tab == num
			return 'active'
		return ''
	componentDidMount: ->
		logout = document.getElementById('logout')
		if logout?
			logout.onclick = (e) =>
				API.logout()
				@forceUpdate()
				e.preventDefault()
	render: ->
		<div className='navbar'>
			<div className="navbar-inner">
				<a className="brand" href="#">Чат</a>
				<ul className="nav" id='buttons'>
					<li className={@isActive(1)}> <a data-num=1 href="">На главную</a></li>
					<li className={@isActive(2)}> <a data-num=2 href="">Комнаты</a></li>
					<li className={@isActive(3)}> <a data-num=3 href="">Заявки</a></li>
					{unless API.isAuthorize
						<li className={@isActive(4)}> <a data-num=4 href="">Войти</a></li>
					}
				</ul>
			{if API.isAuthorize
				<div className='pull-right'>
					Вошли как: {API.nickname} (<a id='logout' href="">Выйти</a>)
				</div>
			}
			</div>
		</div>