package reparto

import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Ganancia {
	Producto producto
	BigDecimal valor
}
