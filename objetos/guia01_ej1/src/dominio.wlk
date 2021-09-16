object tom {
	var energia = 100
	const velocidadBase = 5
	const valorBaseEnergia = 12

	method comerRaton(raton) {
		self.aumentarEnergia(valorBaseEnergia + raton.peso())
	}

	method aumentarEnergia(valor) {
		energia = energia + valor
	}

	method velocidad() = velocidadBase + energia / 10

	method correr(segundos) {
		energia = energia - (0.5 * self.metrosRecorridos(segundos))
	}
	
	method metrosRecorridos(segundos) = segundos * self.velocidad()
	
	method meConvieneComerRatonA(unRaton, unaDistancia) {
		self.comerRaton(unRaton)
	}

}

object jerry {
	const peso = 14

	method peso() = peso
}