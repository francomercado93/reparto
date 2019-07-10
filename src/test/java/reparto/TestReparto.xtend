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
			nombre = "Pan de miga"
			precioBase = new BigDecimal(160)
		]

		arabeBlanco = new Producto() => [
			nombre = "Arabe blanco"
			precioBase = new BigDecimal(50)
		]

		panRallado = new Producto() => [
			nombre = "Pan rallado"
			precioBase = new BigDecimal(80)
		]

		loDePepe = new Cliente() => [
			nombre = "Lo de Pepe"
		]

		laLibertad = new Cliente() => [
			nombre = "La libertad"
		]

		celdaMigaLoDePepe = new Celda() => [
			producto = miga
			cliente = loDePepe
		]

		celdaArabeLoDePepe = new Celda() => [
			producto = arabeBlanco
			cliente = loDePepe
		]

		celdaMigaLaLibertad = new Celda() => [
			producto = miga
			cliente = laLibertad
		]

		celdaArabeLaLibertad = new Celda() => [
			producto = arabeBlanco
			cliente = laLibertad
		]
		celdaPanRalladoLaLibertad = new Celda() => [
			producto = panRallado
			cliente = laLibertad
		]
		filaLaLibertad = new Fila()
		filaLaLibertad.agregarCelda(celdaMigaLaLibertad)
		filaLaLibertad.agregarCelda(celdaArabeLaLibertad)
		filaLaLibertad.agregarCelda(celdaPanRalladoLaLibertad)
		filaLoDePepe = new Fila()
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
		celdaMigaLoDePepe.setPrecioFinal(miga, new BigDecimal(200))
		Assert.assertEquals(0, loDePepe.ganancias.get(miga).compareTo(gananciaEsperada), 0.1)
	}

	@Test(expected=typeof(BusinessException))
	def void precioFinalDeUnProductoDeUnClienteNoPuedeSerMenorOIgualAlPrecioBaseDelProducto() {
		val precioNoValido = new BigDecimal(150)
		celdaMigaLoDePepe.setPrecioFinal(miga, precioNoValido)
	}

	@Test
	def void testPrecioFinalProducto() {
		val precioMigaEsperado = new BigDecimal(200)
		val precioArabeEsperado = new BigDecimal(60)
		celdaMigaLoDePepe.setPrecioFinal(miga, new BigDecimal(200))
		celdaArabeLoDePepe.setPrecioFinal(arabeBlanco, new BigDecimal(60))
		Assert.assertEquals(0, celdaMigaLoDePepe.precioFinal.compareTo(precioMigaEsperado), 0.1)
		Assert.assertEquals(0, celdaArabeLoDePepe.precioFinal.compareTo(precioArabeEsperado), 0.1)
	}

	@Test
	def void testSubtotalFila() {
		val subtotalEsperado = new BigDecimal(260)
		val precioMiga = new BigDecimal(200)
		val precioArabe = new BigDecimal(60)
		celdaMigaLoDePepe.setPrecioFinal(miga, precioMiga)
		celdaArabeLoDePepe.setPrecioFinal(arabeBlanco, precioArabe)
		Assert.assertEquals(0, filaLoDePepe.subtotal.compareTo(subtotalEsperado), 0.1)
	}

	@Test
	def void testGananciaFila() {
		val subtotalEsperado = new BigDecimal(50)
		val precioMiga = new BigDecimal(200)
		val precioArabe = new BigDecimal(60)
		celdaMigaLoDePepe.setPrecioFinal(miga, precioMiga)
		celdaArabeLoDePepe.setPrecioFinal(arabeBlanco, precioArabe)
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
		celdaMigaLoDePepe.setPrecioFinal(miga, precioMigaLoDePepe)
		celdaArabeLoDePepe.setPrecioFinal(arabeBlanco, precioArabeLoDePepe)
		celdaMigaLaLibertad.setPrecioFinal(miga, precioMigaLaLibertad)
		celdaArabeLaLibertad.setPrecioFinal(arabeBlanco, precioArabeLaLibertad)
		celdaPanRalladoLaLibertad.setPrecioFinal(panRallado, precioPanRalladoLaLibertad)
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
		celdaMigaLoDePepe.setPrecioFinal(miga, precioMigaLoDePepe)
		celdaArabeLoDePepe.setPrecioFinal(arabeBlanco, precioArabeLoDePepe)
		celdaMigaLaLibertad.setPrecioFinal(miga, precioMigaLaLibertad)
		celdaArabeLaLibertad.setPrecioFinal(arabeBlanco, precioArabeLaLibertad)
		celdaPanRalladoLaLibertad.setPrecioFinal(panRallado, precioPanRalladoLaLibertad)
		print(planilla.gananciaPlanilla)
		Assert.assertEquals(0, planilla.gananciaPlanilla.compareTo(gananciaEsperada), 0.1)
	}
}
