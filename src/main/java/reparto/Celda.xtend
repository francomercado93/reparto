package reparto

import org.eclipse.xtend.lib.annotations.Accessors
import java.math.BigDecimal
import exceptions.BusinessException

@Accessors
class Celda {
	Producto producto
	Cliente cliente

	def getPrecioFinal() {
		producto.precioBase + cliente.getGananciaProducto(producto.id)
	}

	def setPrecioFinal(BigDecimal valorFinal) {
		val ganancia = valorFinal - producto.precioBase
		if (ganancia.compareTo(new BigDecimal(0)) <= 0) {
			throw new BusinessException("El precio final debe ser mayor a " + producto.precioBase)
		}
		cliente.asignarGanancia(producto.id, ganancia)
	}

	def getGanancia() {
		cliente.getGananciaProducto(producto.id)
	}

}
