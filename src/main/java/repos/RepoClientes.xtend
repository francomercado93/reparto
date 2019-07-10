package repos

import reparto.Cliente

class RepoClientes extends RepoDefault<Cliente> {

	static RepoClientes instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoClientes()
		}
		instance
	}

	override getEntityType() {
		Cliente
	}

}
