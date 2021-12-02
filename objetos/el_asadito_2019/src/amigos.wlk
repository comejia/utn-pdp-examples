import criterios.*

class UserException inherits Exception {}

class Persona {
	var property posicion = 1
	var property elementosCerca = []
	var property criterioDePasar = pasarElemento
	var property criterioDeComida = vegetariano
	var property comidas = []

	method mePasas(algo, aQuien) {
		if (!self.tieneElemento(algo)) {
			throw new UserException(message = "El comensal debe tener el elemento para pasarlo")
		}
		criterioDePasar.aplicarCriterio(self, aQuien, algo)
	}

	method eliminarElemento(elemento) {
		elementosCerca.remove(elemento)
	}

	method agregarElemento(elemento) {
		elementosCerca.add(elemento)
	}

	method tieneElemento(algo) = elementosCerca.contains(algo)

	method comer(comida) {
		if (self.puedeComer(comida)) {
			comidas.add(comida)
		} //else {
			//throw new UserException(message = "El comensal no puede comer la comida")
		//}
	}

	method puedeComer(comida) = criterioDeComida.cumpleCriterio(comida)

	method estaPipon() = comidas.any({ comida => comida.esPesada() })

	//method esPesada(comida) = comida.calorias() > 500

	method laEstaPasandoBien() = self.comioAlgo() && self.condicion()

	method comioAlgo() = !comidas.isEmpty()

	method condicion()

}

object osky inherits Persona {
	override method condicion() = true
}

object moni inherits Persona {
	override method condicion() = self.posicion() == 1
}

object facu inherits Persona {
	override method condicion() = self.comioCarne()

	method comioCarne() = comidas.any({ comida => comida.esCarne() })
}

object vero inherits Persona {
	override method condicion() = elementosCerca.size() <= 3
}


// Punto 5) - Donde se utiliza:
// Polimorfismo: se usa en el punto 1) para definir los criterios de pasar algo. En el 2) para las comidas
// y en el punto 4) en la condicion de una persona para pasarla bien

// Herencia: en el punto 4) para definir las distintas personas

// Composicion: en 1) y 2), al tener una persona el criterio de pasar algo y de comer





