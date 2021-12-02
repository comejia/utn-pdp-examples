class Persona {
	var property anticuerpos
	var property inmunidad
	const property edad
	const property nombre
	const property provincia
	var property criterioDeVacuna
	const property historialDeVacunas = []

	method seAplicaVacuna(vacuna) = criterioDeVacuna.seAplicaVacuna(vacuna, self) // falta parametro mesesDeInmunidad?
	
	method nombrePar() = nombre.length().even()
	
	//method esEspecial() = provincia == "Tierra del Fuego" || provincia == "Santa Cruz" || provincia == "Neuquen"
	method esEspecial() = lugaresEspeciales.any{ lugar => lugar == provincia }
	
	method registrarVacuna(vacuna) {
		historialDeVacunas.add(vacuna)	
	}
	
		
	method vacunar(vacuna) {
		anticuerpos = vacuna.anticuerposQueOtorga(self)
		inmunidad = vacuna.inmunidadQueOtorga(self)
	}
	
}


const lugaresEspeciales = ["Tierra del Fuego", "Santa Cruz", "Neuquen"]


object cualquierosas {
	method seAplicaVacuna(vacuna, persona) = true
}

object anticuerposas {
	method seAplicaVacuna(vacuna, persona) = vacuna.anticuerposQueOtorga(persona) > 100000
}

object inmunidosasFijas {
	method seAplicaVacuna(vacuna, persona) = vacuna.inmunidadQueOtorga(persona) > new Date(day = 5, month = 3, year = 2022)
}

object inmunidosasVariables {
	var property mesesDeInmunidad = 8

	method seAplicaVacuna(vacuna, persona) = vacuna.inmunidadQueOtorga(persona) > new Date().plusMonths(mesesDeInmunidad)
}




