package reparto

import exceptions.BusinessException
import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Celda {

	Producto producto
	BigDecimal cantidad

	new(Producto prod, BigDecimal cant) {
		producto = prod
		cantidad = cant
	}

	new() {
	}

	def getPrecioFinal(Cliente cliente) {
		producto.precioBase + cliente.getGananciaProducto(producto.id)
	}

	def setPrecioFinal(BigDecimal valorFinal, Cliente cliente) {
		val ganancia = valorFinal - producto.precioBase
		if (ganancia.compareTo(new BigDecimal(0)) <= 0) {
			throw new BusinessException("El precio final debe ser mayor a " + producto.precioBase)
		}
		cliente.asignarGanancia(producto.id, ganancia)
	}
	
	def getPrecioCelda(Cliente cliente){
		this.getPrecioFinal(cliente) * cantidad
	}

	def getGanancia(Cliente cliente) {
		cliente.getGananciaProducto(producto.id)
	}

}
