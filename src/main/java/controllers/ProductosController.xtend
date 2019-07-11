package controllers

import application.RepartoBootstrap
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils

@Controller
class ProductosController {

	extension JSONUtils = new JSONUtils

	@Get("/productos")
	def Result entradasUsr() {
		try {
			print("holis")
			ok(RepartoBootstrap.instance.productos.toJson)
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

}
