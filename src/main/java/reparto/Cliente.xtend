package reparto

import java.math.BigDecimal
import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Cliente {
	String nombre
	Map<Producto, BigDecimal> ganancias
//	List<Ganancia> ganancias

	new() {
		ganancias = newHashMap
//		ganancias = newArrayList
	}

	def asignarGanancia(Producto producto, BigDecimal numero) {
//		val nuevaGanancia = new Ganancia => [
//			producto = prod
//			valor = numero
//		]
//		ganancias.add(nuevaGanancia)
		ganancias.put(producto, numero)
	}

	def getGananciaProducto(Producto producto) {
//		val buscado = ganancias.findFirst[ganancia|ganancia.producto.nombre == producto.nombre]
//		buscado.valor
		ganancias.get(producto)
	}

}
