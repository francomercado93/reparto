package controllers

import application.RepartoBootstrap
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils

@Controller
class ClientesController {
	extension JSONUtils = new JSONUtils

	@Get('/clientes')
	def Result entradasUsr() {
		try {
			ok(RepartoBootstrap.instance.clientes.toJson)
		} catch (UserException e) {
			notFound("No se encontraron clientes")
		}
	}
}
