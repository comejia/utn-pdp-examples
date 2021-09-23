object tom {
	var energia = 100
	const ratonesEnemigos = [jerry, splinter]

	const velocidadBase = 5
	const valorBaseEnergia = 12

	method comerRaton(raton) {
		energia = energia + self.incrementoPorComerUnRaton(raton)
	}
	
	method ratonesQuePuedeComer() = ratonesEnemigos.filter({ unRaton => self.meConvieneComerRatonA(unRaton) })
	
	method nombreDeRatonesEnemigos() = ratonesEnemigos.map({ unRaton => unRaton.nombre() })
	
	method incrementoPorComerUnRaton(raton) = valorBaseEnergia + raton.peso()

	method velocidad() = velocidadBase + energia / 10

	method correr(segundos) {
		energia = energia - self.decrementoDeEnergiaPorCorrer(segundos)
	}
	
	method decrementoDeEnergiaPorCorrer(segundos) = 0.5 * self.metrosRecorridos(segundos)
	
	method metrosRecorridos(segundos) = segundos * self.velocidad()
	
	method meConvieneComerRatonA(unRaton) = self.incrementoPorComerUnRaton(unRaton) > self.decrementoDeEnergiaPorCorrer(unRaton.segundos())

}

object jerry {
	const peso = 14

	method peso() = peso
	
	method nombre() = "Jerry"
	
	method segundos() = 5
}

object splinter {
	method peso() = 200
	
	method nombre() = "Splinter"
	
	method segundos() = 10
}
