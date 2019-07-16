package reparto

import java.math.BigDecimal
import java.util.Map
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import com.fasterxml.jackson.annotation.JsonIgnore

@Entity
@Accessors
class Cliente {

	@Id @GeneratedValue
	Long id

	@Column(length=150)
	String nombre

//	@ElementCollection(fetch=FetchType.EAGER)
//	@CollectionTable(name="Ganancias_Cliente", joinColumns=@JoinColumn(name="cliente_id"))
//	@Column(name="ganancias")
	@Transient
	@JsonIgnore
	Map<Long, BigDecimal> ganancias

	new() {
		ganancias = newHashMap
	}

	new(String name) {
		nombre = name
		ganancias = newHashMap
	}

	def asignarGanancia(Long idProducto, BigDecimal numero) {
		ganancias.put(idProducto, numero)
	}

	def getGananciaProducto(Long idProducto) {
		ganancias.get(idProducto)
	}

}
