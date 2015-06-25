Orders = React.createClass
	getInitialState: ->
		{orders: [] }
	
	render: ->
		React.createElement("div", {"className": "container"},
			React.createElement("div", {"className": "row"},
				React.createElement("h3", null, " \u0418\u043d\u0432\u0430\u0439\u0442\u044b "),
				React.createElement("table", {"className": "table table-hover"},
					React.createElement("tbody", null,
						React.createElement("tr", null,
							React.createElement("td", null, """ \u041d\u0430\u0437\u0432\u0430\u043d\u0438\u0435 \u043a\u043e\u043c\u043d\u0430\u0442\u044b
"""),
							React.createElement("td", null,
								React.createElement("button", {"className": "btn btn-inverse pull-right", "id": "confirm"}, "\u041f\u043e\u0434\u0442\u0432\u0435\u0440\u0434\u0438\u0442\u044c")
							)
						)
					)
				)
			),

			React.createElement("div", {"className": "row"},
				React.createElement("h3", null, " \u0422\u0440\u0435\u0431\u0443\u044e\u0442 \u043f\u043e\u0434\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f "),
				React.createElement("table", {"className": "table table-hover"},
					React.createElement("tbody", null,
						React.createElement("tr", null,
							React.createElement("th", null, "\u041f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u044c"),
							React.createElement("th", null, "\u041a\u043e\u043c\u043d\u0430\u0442\u0430"),
							React.createElement("th", null, "\u041e\u043f\u0446\u0438\u0438")
						),
						React.createElement("tr", null,
							React.createElement("td", null, """ \u041d\u0438\u043a \u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u044f
"""),
							React.createElement("td", null, """ \u041d\u0430\u0437\u0432\u0430\u043d\u0438\u0435 \u043a\u043e\u043c\u043d\u0430\u0442\u044b
"""),
							React.createElement("td", null,
								React.createElement("button", {"className": "btn btn-inverse pull-right", "id": "confirm"}, "\u041f\u043e\u0434\u0442\u0432\u0435\u0440\u0434\u0438\u0442\u044c")
							)
						)
					)
				)
			)
		)