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
		React.createElement("div", {"className": 'navbar'},
			React.createElement("div", {"className": "navbar-inner"},
				React.createElement("a", {"className": "brand", "href": "#"}, "\u0427\u0430\u0442"),
				React.createElement("ul", {"className": "nav", "id": 'buttons'},
					React.createElement("li", {"className": (@isActive(1))}, " ", React.createElement("a", {"data-num": 1, "href": ""}, "\u041d\u0430 \u0433\u043b\u0430\u0432\u043d\u0443\u044e")),
					React.createElement("li", {"className": (@isActive(2))}, " ", React.createElement("a", {"data-num": 2, "href": ""}, "\u041a\u043e\u043c\u043d\u0430\u0442\u044b")),
					React.createElement("li", {"className": (@isActive(3))}, " ", React.createElement("a", {"data-num": 3, "href": ""}, "\u0417\u0430\u044f\u0432\u043a\u0438")),
					(unless API.isAuthorize
						React.createElement("li", {"className": (@isActive(4))}, " ", React.createElement("a", {"data-num": 4, "href": ""}, "\u0412\u043e\u0439\u0442\u0438"))
					)
				),
			(if API.isAuthorize
				React.createElement("div", {"className": 'pull-right'}, """
\t\t\t\t\t\u0412\u043e\u0448\u043b\u0438 \u043a\u0430\u043a: """, (API.nickname), " (", React.createElement("a", {"id": 'logout', "href": ""}, "\u0412\u044b\u0439\u0442\u0438"), """)
""")
			)
			)
		)