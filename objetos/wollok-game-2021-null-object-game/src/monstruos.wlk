import wollok.game.*
import recorridos.*

class Monstruo {
	var property fuerza = 100
	var property camino = recorrido
	var property position = camino.posicionInicial()

	method avanzar() {
		position = camino.siguientePosicion(self)
	}

	method llegoAlFinal() = position == camino.posicionFinal()

	method image()

	method estaSinFuerza() = fuerza <= 0

	method golpeado(proyectil) {
		fuerza = fuerza - proyectil.danio()
		proyectil.remover()
	}

}

class Elemental inherits Monstruo {

	override method image() = "elemental.png"

}

class Agil inherits Monstruo {

	var property velocidad = 1

	override method image() = "agil.png"

	override method avanzar() {
		velocidad.times({ i => super() })
	}

	override method golpeado(proyectil) {
		velocidad = velocidad + 1
		fuerza = fuerza - proyectil.danio() * 1.2
		proyectil.remover()
	}

}

class Fortachon inherits Monstruo(fuerza = 300) {
	var property escudos = 3

	override method image() = "fortachon.png"

	override method golpeado(proyectil) {
		if (self.escudosActivos()) {
			escudos = escudos - 1
			proyectil.remover()
		} else {
			super(proyectil)		
		}
	}

	method escudosActivos() = escudos > 0

}

class Loco inherits Monstruo {

	const toleranciaLocura = fuerza * 0.8

	override method image() = "loco.png"

	override method avanzar() {
		position = if (self.sigueCuerdo()) camino.siguientePosicion(self) else camino.posicionAleatoria()
	}

	method sigueCuerdo() = fuerza > toleranciaLocura 

}
