import espacios_urbanos.*
import registros.*

class Persona {
	var property profesion

	method puedeTrabajar(espacio) = profesion.puedeTrabajar(espacio)

	method realizarTrabajo(espacio) = profesion.realizarTrabajo(espacio)

	method duracionDeTrabajo(espacio) = profesion.duracionDeTrabajo(espacio)

	method costoTrabajo(espacio) = profesion.costoTrabajo(espacio)

	method trabajoHeavy(espacio) = profesion.trabajoHeavy(espacio)
}

class Profesion {
	var property valorHora = 100

	method puedeTrabajar(espacio)
	method realizarTrabajo(espacio)
	method duracionDeTrabajo(espacio)
	method costoTrabajo(espacio) = valorHora * self.duracionDeTrabajo(espacio)
	method trabajoHeavy(espacio) = self.costoTrabajo(espacio) > 10000
}

object cerrajero inherits Profesion {

	override method puedeTrabajar(espacio) = !espacio.tieneVallado()

	override method realizarTrabajo(espacio) {
		espacio.tieneVallado(true)
	}

	override method duracionDeTrabajo(espacio) = if (espacio.esGrande()) 5 else 3

	override method trabajoHeavy(espacio) = super(espacio) || self.duracionDeTrabajo(espacio) > 5
}

object jardinero inherits Profesion {
	override method puedeTrabajar(espacio) = espacio.esEspacioVerde()

	override method realizarTrabajo(espacio) {
		espacio.aumentarValor(espacio.valuacion() * 0.1)
	}

	override method duracionDeTrabajo(espacio) = 1 * (espacio.superficie() / 10)

	override method costoTrabajo(espacio) = 2500
}

object encargado inherits Profesion {
	override method puedeTrabajar(espacio) = espacio.esEspacioLimpiable()

	override method realizarTrabajo(espacio) {
		espacio.aumentarValor(5000)
	}

	override method duracionDeTrabajo(espacio) = 8 
}

// Punto 2 - Mostrar, en consola, que una persona comience como cerrajero y pase a jardinero
// var tito = new Persona(profesion = cerrajero)
// tito.profesion(jardinero)

