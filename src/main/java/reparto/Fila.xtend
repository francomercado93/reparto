package reparto

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.math.BigDecimal

@Accessors
class Fila {

	List<Celda> celdas

	new() {
		celdas = newArrayList
	}

	def getSubtotal() {
		new BigDecimal(celdas.fold(0d, [acum, celda|acum + celda.precioFinal]))
	}

	def agregarCelda(Celda celda) {
		celdas.add(celda)
	}

	def getGananciaFila() {
		new BigDecimal(celdas.fold(0d, [acum, celda|acum + celda.ganancia]))
	}
	
}
