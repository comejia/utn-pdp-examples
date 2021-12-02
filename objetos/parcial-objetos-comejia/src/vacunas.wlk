import personas.*

class Vacuna {
	const property costoInicial = 1000

	method anticuerposQueOtorga(persona)

	method inmunidadQueOtorga(persona)

	method costo(persona) = costoInicial + self.incrementoPorAnio(persona) + self.costoExtra(persona)

	method incrementoPorAnio(persona) = (persona.edad() - 30).max(0) * 50

	method costoExtra(persona)

}

object paifer inherits Vacuna {

	override method anticuerposQueOtorga(persona) = 10 * persona.anticuerpos()
 
	override method inmunidadQueOtorga(persona) = if (persona.edad() > 40) new Date().plusMonths(6) else new Date().plusMonths(9)

	override method costoExtra(persona) = if (persona.edad() < 18) 400 else 100

}

class Larussa inherits Vacuna {
	var property efectoMultiplicador

	override method anticuerposQueOtorga(persona) = efectoMultiplicador.max(20) * persona.anticuerpos()

	override method inmunidadQueOtorga(persona) = new Date(day = 3, month = 3, year = 2022)

	override method costoExtra(persona) = 100 * efectoMultiplicador
	
}

const larussa5 = new Larussa(efectoMultiplicador = 5)
const larussa2 = new Larussa(efectoMultiplicador = 2)


object astraLaVistaZeneca inherits Vacuna {
	override method anticuerposQueOtorga(persona) = 10000 + persona.anticuerpos()

	override method inmunidadQueOtorga(persona) = if (persona.nombrePar()) new Date().plusMonths(6) else new Date().plusMonths(7)

	override method costoExtra(persona) = if (persona.esEspecial()) 2000 else 0
}

object combineta inherits Vacuna {
	const property compuestos = [larussa2, paifer]

	override method anticuerposQueOtorga(persona) = compuestos.min { compuesto => compuesto.anticuerposQueOtorga(persona) }

	override method inmunidadQueOtorga(persona) = compuestos.max { compuesto => compuesto.inmunidadQueOtorga(persona) }

	override method costoExtra(persona) = self.costoTotalDeCompuestos(persona) + self.cantidadDeCompuestos() * 100

	method costoTotalDeCompuestos(persona) = compuestos.sum { compuesto => compuesto.costo(persona) }

	method cantidadDeCompuestos() = compuestos.size()
}


class UserException inherits Exception {}

object ministerioDeSalud {
	const property vacunasDisponibles = [paifer, larussa5, larussa2, astraLaVistaZeneca, combineta]
	const property personasAVacunar = []
	
	method costoTotalPlanInicial(personas) = self.descartarALosOutsiders(personas).map{ persona =>  self.costoVacunaMasBarata(persona)}.sum()

	method costoVacunaMasBarata(persona) = self.vacunaMasBarataQueAdmite(persona).costo(persona)

	method vacunaMasBarataQueAdmite(persona) = self.vacunasQueAdmite(persona).min{ vacuna => vacuna.costo(persona) }

	method vacunasQueAdmite(persona) = vacunasDisponibles.filter{ vacuna => persona.seAplicaVacuna(vacuna) }


	method descartarALosOutsiders(personas) = personas.filter{ persona => !self.vacunasQueAdmite(persona).isEmpty() }

	
	
	method confirmarTurno(persona, vacuna) {
		if(!persona.seAplicaVacuna(vacuna)) {
			throw new UserException(message = "La vacuna solicitada no es aplicable para la persona")
		}
		persona.vacunar(vacuna)
		persona.registrarVacuna(vacuna)
	}
	
}


