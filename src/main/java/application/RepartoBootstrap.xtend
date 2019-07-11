package application

import java.math.BigDecimal
import reparto.Cliente
import reparto.Producto
import repos.RepoClientes
import repos.RepoProductos

class RepartoBootstrap {

	static RepartoBootstrap instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepartoBootstrap()
		}
		instance
	}

	Cliente taka
	Cliente sandwicheria
	Producto miga
	Producto arabe
	Producto arabeNegro
	Producto panRallado
	Producto capelina
	Producto tartin
	Producto pizza
	RepoProductos repoProductos
	RepoClientes repoClientes

	new() {
		print("Inicio\n")
		initRepos()
		initClientes()
		initProductos()
	}

	def initRepos() {
		repoProductos = RepoProductos.instance
		repoClientes = RepoClientes.instance
	}

	def crearProducto(Producto producto) {
		repoProductos.create(producto)
		print(producto.nombre + "creado correctamente")
	}

	def initClientes() {
		taka = new Cliente("Taka pan")
		sandwicheria = new Cliente("Sandwicheria")
		this.crearCliente(taka)
		this.crearCliente(sandwicheria)
	}

	def initProductos() {
		miga = new Producto("Pan de miga", new BigDecimal(160))
		arabe = new Producto("Arabe", new BigDecimal(40))
		arabeNegro = new Producto("Arabe negro", new BigDecimal(30))
		panRallado = new Producto("Pan rallado", new BigDecimal(100))
		capelina = new Producto("Capelina", new BigDecimal(7.5))
		tartin = new Producto("Tartin", new BigDecimal(4.5))
		pizza = new Producto("Pizza", new BigDecimal(6.5))
		this.crearProducto(miga)
		this.crearProducto(arabe)
		this.crearProducto(arabeNegro)
		this.crearProducto(panRallado)
		this.crearProducto(capelina)
		this.crearProducto(tartin)
		this.crearProducto(pizza)
	}

	def crearCliente(Cliente cliente) {
		repoClientes.create(cliente)
	}

	def getClientes() {
		repoClientes.allInstances()
	}

	def getProductos() {
		repoProductos.allInstances()
	}

}
