package application

import controllers.ClientesController
import controllers.ProductosController
import org.uqbar.xtrest.api.XTRest

class RepartoApp {
	def static void main(String[] args) {
		XTRest.start(9000, ClientesController, ProductosController)
	}
}
