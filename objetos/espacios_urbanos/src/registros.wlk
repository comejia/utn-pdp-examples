class UserException inherits Exception {}

object registrosDeTrabajo {
	var property calendario = calendarioActual
	const trabajosRealizados = []

	method registrarTrabajo(persona, espacio) {
		if (!persona.puedeTrabajar(espacio)) {
			throw new UserException(message = "La persona no puede realizar el trabajo")
		}
		persona.realizarTrabajo(espacio)

		trabajosRealizados.add(
			new Registro(fecha = calendario.fechaDeHoy(), persona = persona, espacioUrbano = espacio)
		)
	}
	
	method espaciosDeUsoIntensivo() = self.espaciosHeaviesDelMes().asSet().filter{ 
		espacioUrbano => self.espaciosHeaviesDelMes().occurrencesOf(espacioUrbano) > 5
	}

	method espaciosHeaviesDelMes() = self.trabajosHeaviesDelMes().map{ trabajo => trabajo.espacioUrbano() }

	method trabajosHeaviesDelMes() = self.trabajosDelUltimoMes().filter{ trabajo => self.esTrabajoHeavy(trabajo) }
	
	method esTrabajoHeavy(trabajo) = trabajo.persona().trabajoHeavy(trabajo.espacioUrbano())

	method trabajosDelUltimoMes() = trabajosRealizados.filter({ trabajo => self.esDelUltimoMes(trabajo) })

	method esDelUltimoMes(trabajo) = (calendario.fechaDeHoy() - trabajo.fecha()) <= 30
}

class Registro {
	var property fecha
	var property persona
	var property espacioUrbano

	method duracion() = persona.duracionDeTrabajo(espacioUrbano)

	method costo() = persona.costoTrabajo(espacioUrbano)
}

object calendarioActual {
	method fechaDeHoy() = new Date()
}

