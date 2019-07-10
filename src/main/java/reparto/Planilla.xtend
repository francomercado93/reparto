package reparto

import java.math.BigDecimal
import java.time.LocalDate
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Planilla {

	List<Fila> filas
	LocalDate fecha

	new(LocalDate date) {
		filas = newArrayList
		fecha = date
	}

	def getTotal() {
		new BigDecimal(filas.fold(0d, [acum, fila|acum + fila.subtotal]))
	}

	def agregarFilas(Fila fila) {
		filas.add(fila)
	}
	
	def getGananciaPlanilla() {
		new BigDecimal(filas.fold(0d, [acum, fila|acum + fila.gananciaFila]))
	}
	
}
