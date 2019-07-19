package reparto

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.math.BigDecimal

@Accessors
class Fila {

	List<Celda> celdas
	Cliente cliente

	new() {
		celdas = newArrayList
	}

	new(Cliente _cliente) {
		celdas = newArrayList
		cliente = _cliente
	}

	def getSubtotal() {
		new BigDecimal(celdas.fold(0d, [acum, celda|acum + celda.getPrecioFinal(cliente)]))
	}

	def agregarCelda(Celda celda) {
		celdas.add(celda)
	}

	def getGananciaFila() {
		new BigDecimal(celdas.fold(0d, [acum, celda|acum + celda.getGanancia(cliente)]))
	}

}
