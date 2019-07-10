package reparto

import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Producto {
	String nombre
	BigDecimal precioBase
}