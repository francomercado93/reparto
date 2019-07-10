package reparto

import java.math.BigDecimal
import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Cliente {
	String nombre
	Map<Producto, BigDecimal> ganancias

	new() {
		ganancias = newHashMap
	}

	new(String name) {
		nombre = name
		ganancias = newHashMap
	}

	def asignarGanancia(Producto producto, BigDecimal numero) {
		ganancias.put(producto, numero)
	}

	def getGananciaProducto(Producto producto) {
		ganancias.get(producto)
	}

}
