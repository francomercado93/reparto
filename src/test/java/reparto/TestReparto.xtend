package reparto

import exceptions.BusinessException
import java.math.BigDecimal
import java.time.LocalDate
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestReparto {
	Producto miga
	Producto arabeBlanco
	Producto panRallado
	Cliente loDePepe
	Cliente laLibertad
	Celda celdaMigaLoDePepe
	Celda celdaArabeLoDePepe
	Celda celdaMigaLaLibertad
	Celda celdaArabeLaLibertad
	Celda celdaPanRalladoLaLibertad
	Fila filaLaLibertad
	Fila filaLoDePepe

	Planilla planilla

	@Before
	def void init() {
		miga = new Producto() => [
			id = new Long(0)
			nombre = "Pan de miga"
			precioBase = new BigDecimal(160)
		]

		arabeBlanco = new Producto() => [
			id = new Long(1)
			nombre = "Arabe blanco"
			precioBase = new BigDecimal(50)
		]

		panRallado = new Producto() => [
			id = new Long(2)
			nombre = "Pan rallado"
			precioBase = new BigDecimal(80)
		]

		loDePepe = new Cliente() => [
			id = new Long(10)
			nombre = "Lo de Pepe"
		]

		laLibertad = new Cliente() => [
			id = new Long(11)
			nombre = "La libertad"
		]

		celdaMigaLoDePepe = new Celda() => [
			producto = miga
		]

		celdaArabeLoDePepe = new Celda() => [
			producto = arabeBlanco
		]

		celdaMigaLaLibertad = new Celda() => [
			producto = miga
		]

		celdaArabeLaLibertad = new Celda() => [
			producto = arabeBlanco
		]
		celdaPanRalladoLaLibertad = new Celda() => [
			producto = panRallado
		]
		filaLaLibertad = new Fila(laLibertad)
		filaLaLibertad.agregarCelda(celdaMigaLaLibertad)
		filaLaLibertad.agregarCelda(celdaArabeLaLibertad)
		filaLaLibertad.agregarCelda(celdaPanRalladoLaLibertad)
		filaLoDePepe = new Fila(loDePepe)
		filaLoDePepe.agregarCelda(celdaMigaLoDePepe)
		filaLoDePepe.agregarCelda(celdaArabeLoDePepe)
		val fechaPlanilla = LocalDate.of(2019, 07, 09)
		planilla = new Planilla(fechaPlanilla)
		planilla.agregarFilas(filaLaLibertad)
		planilla.agregarFilas(filaLoDePepe)
	}

	@Test
	def void testCreacionProductos() {
		Assert.assertEquals(0, miga.precioBase.compareTo(new BigDecimal(160)), 0.1)
		Assert.assertEquals(0, arabeBlanco.precioBase.compareTo(new BigDecimal(50)), 0.1)
	}

	@Test
	def void testAsignacionPrecioFinalDeUnProductoDeUnClienteYValorRecargoDelProductoDeUnCliente() {
		val gananciaEsperada = new BigDecimal(40)
		celdaMigaLoDePepe.setPrecioFinal(new BigDecimal(200), loDePepe)
		Assert.assertEquals(0, loDePepe.ganancias.get(miga.id).compareTo(gananciaEsperada), 0.1)
	}

	@Test
	def void testGetPrecioFinalProducto() {
		val precioDeseado = new BigDecimal(200)
		celdaMigaLoDePepe.setPrecioFinal(new BigDecimal(200), loDePepe)
		Assert.assertEquals(0, celdaMigaLoDePepe.getPrecioFinal(loDePepe).compareTo(precioDeseado), 0.1)
	}
	
	@Test
	def void testGetPrecioCelda() {
		val precioDeseado = new BigDecimal(600)
		celdaMigaLoDePepe.cantidad = new BigDecimal(3)
		celdaMigaLoDePepe.setPrecioFinal(new BigDecimal(200), loDePepe)
		Assert.assertEquals(0, celdaMigaLoDePepe.getPrecioCelda(loDePepe).compareTo(precioDeseado), 0.1)
	}

	@Test(expected=typeof(BusinessException))
	def void precioFinalDeUnProductoDeUnClienteNoPuedeSerMenorOIgualAlPrecioBaseDelProducto() {
		val precioNoValido = new BigDecimal(150)
		celdaMigaLoDePepe.setPrecioFinal(precioNoValido, loDePepe)
	}

	@Test
	def void testPrecioFinalProducto() {
		val precioMigaEsperado = new BigDecimal(200)
		val precioArabeEsperado = new BigDecimal(60)
		celdaMigaLoDePepe.setPrecioFinal(new BigDecimal(200), loDePepe)
		celdaArabeLoDePepe.setPrecioFinal(new BigDecimal(60), loDePepe)
		Assert.assertEquals(0, celdaMigaLoDePepe.getPrecioFinal(loDePepe).compareTo(precioMigaEsperado), 0.1)
		Assert.assertEquals(0, celdaArabeLoDePepe.getPrecioFinal(loDePepe).compareTo(precioArabeEsperado), 0.1)
	}

	@Test
	def void testSubtotalFila() {
		val subtotalEsperado = new BigDecimal(260)
		val precioMiga = new BigDecimal(200)
		val precioArabe = new BigDecimal(60)
		celdaMigaLoDePepe.setPrecioFinal(precioMiga, loDePepe)
		celdaArabeLoDePepe.setPrecioFinal(precioArabe, loDePepe)
		Assert.assertEquals(0, filaLoDePepe.subtotal.compareTo(subtotalEsperado), 0.1)
	}

	@Test
	def void testGananciaFila() {
		val subtotalEsperado = new BigDecimal(50)
		val precioMiga = new BigDecimal(200)
		val precioArabe = new BigDecimal(60)
		celdaMigaLoDePepe.setPrecioFinal(precioMiga, loDePepe)
		celdaArabeLoDePepe.setPrecioFinal(precioArabe, loDePepe)
		Assert.assertEquals(0, filaLoDePepe.gananciaFila.compareTo(subtotalEsperado), 0.1)
	}

	@Test
	def void testTotalPlanilla() {
		val totalEsperado = new BigDecimal(595)
		val precioMigaLoDePepe = new BigDecimal(200)
		val precioArabeLoDePepe = new BigDecimal(60)
		val precioMigaLaLibertad = new BigDecimal(180)
		val precioArabeLaLibertad = new BigDecimal(55)
		val precioPanRalladoLaLibertad = new BigDecimal(100)
		celdaMigaLoDePepe.setPrecioFinal(precioMigaLoDePepe, loDePepe)
		celdaArabeLoDePepe.setPrecioFinal(precioArabeLoDePepe, loDePepe)
		celdaMigaLaLibertad.setPrecioFinal(precioMigaLaLibertad, laLibertad)
		celdaArabeLaLibertad.setPrecioFinal(precioArabeLaLibertad, laLibertad)
		celdaPanRalladoLaLibertad.setPrecioFinal(precioPanRalladoLaLibertad, laLibertad)
		Assert.assertEquals(0, planilla.total.compareTo(totalEsperado), 0.1)
	}

	@Test
	def void testGananciaPlanilla() {
		val gananciaEsperada = new BigDecimal(95)
		val precioMigaLoDePepe = new BigDecimal(200)
		val precioArabeLoDePepe = new BigDecimal(60)
		val precioMigaLaLibertad = new BigDecimal(180)
		val precioArabeLaLibertad = new BigDecimal(55)
		val precioPanRalladoLaLibertad = new BigDecimal(100)
		celdaMigaLoDePepe.setPrecioFinal(precioMigaLoDePepe, loDePepe)
		celdaArabeLoDePepe.setPrecioFinal(precioArabeLoDePepe, loDePepe)
		celdaMigaLaLibertad.setPrecioFinal(precioMigaLaLibertad, laLibertad)
		celdaArabeLaLibertad.setPrecioFinal(precioArabeLaLibertad, laLibertad)
		celdaPanRalladoLaLibertad.setPrecioFinal(precioPanRalladoLaLibertad, laLibertad)
		print(planilla.gananciaPlanilla)
		Assert.assertEquals(0, planilla.gananciaPlanilla.compareTo(gananciaEsperada), 0.1)
	}
}
