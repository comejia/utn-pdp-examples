class CriterioDePasar { //agregar template method 
	method aplicarCriterio(personaQueDa, personaQueRecibe, elemento) {
		const cosa = self.elementosAPasar(personaQueDa, elemento)
		personaQueDa.eliminarElemento(cosa)
		personaQueRecibe.agregarElemento(cosa)
	}

	method elementosAPasar(personaQueDa, elemento)
}

object pasarElPrimero inherits CriterioDePasar {

	override method aplicarCriterio(persona, otraPersona, elemento) {
		const cosa = persona.elementosCerca().first()
		persona.eliminarElemento(cosa)
		otraPersona.agregarElemento(cosa)
	}

	override method elementosAPasar(personaQueDa, elemento) = personaQueDa.elementosCerca().first()

}

object pasarTodo inherits CriterioDePasar {

	override method aplicarCriterio(persona, otraPersona, elemento) {
		 const cosas = persona.elementosCerca()
		 persona.elementosCerca([])
		 cosas.forEach( { cosa => otraPersona.agregarElemento(cosa) })
	}

	override method elementosAPasar(personaQueDa, elemento) = personaQueDa.elementosCerca()

}


object cambiarLugar {

	method aplicarCriterio(persona, otraPersona, elemento) {
		const posicionPersona = persona.posicion()
		const posicionOtraPersona = otraPersona.posicion()

		persona.posicion(posicionOtraPersona)
		otraPersona.posicion(posicionPersona)
	}

}


object pasarElemento inherits CriterioDePasar {

	override method aplicarCriterio(persona, otraPersona, elemento) {
		persona.eliminarElemento(elemento)
		otraPersona.agregarElemento(elemento)		
	}

	override method elementosAPasar(personaQueDa, elemento) = elemento
}


object vegetariano {
	method cumpleCriterio(comida) = !comida.esCarne() 
}

object dietetico {
	var property caloriasMaxima = 500
	method cumpleCriterio(comida) = comida.calorias() < caloriasMaxima
}

class Alternado {
	var quiero = false
	method cumpleCriterio(comida) {
		quiero = !quiero
		return quiero
	}

}

class Combinacion {
	const property criteriosDeAceptacion = []
	method cumpleCriterio(comida) = criteriosDeAceptacion.all{ criterio => criterio.cumpleCriterio(comida) }
}


