package repos

import reparto.Producto

class RepoProductos extends RepoDefault<Producto> {

	static RepoProductos instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoProductos()
		}
		instance
	}

	override getEntityType() {
		Producto
	}

}
