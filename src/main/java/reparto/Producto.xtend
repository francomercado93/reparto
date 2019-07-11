package reparto

import java.math.BigDecimal
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Entity
@Accessors
class Producto {

	@Id @GeneratedValue
	Long id

	String nombre
	BigDecimal precioBase

	new() {
	}

	new(String name, BigDecimal precio) {
		nombre = name
		precioBase = precio
	}
}
