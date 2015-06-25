Orders = React.createClass
	getInitialState: ->
		{orders: [] }
	
	render: ->
		<div className="container">
			<div className="row">
				<h3> Инвайты </h3>
				<table className="table table-hover">
					<tbody>
						<tr>
							<td> Название комнаты
							</td>
							<td>
								<button className="btn btn-inverse pull-right" id="confirm" >Подтвердить</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div className="row">
				<h3> Требуют подтверждения </h3>
				<table className="table table-hover">
					<tbody>
						<tr>
							<th>Пользователь</th>
							<th>Комната</th>
							<th>Опции</th>
						</tr>
						<tr>
							<td> Ник пользователя
							</td>
							<td> Название комнаты
							</td>
							<td>
								<button className="btn btn-inverse pull-right" id="confirm" >Подтвердить</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>