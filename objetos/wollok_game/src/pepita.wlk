import wollok.game.*

object pepita {
	var property enemigo = silvestre
	var property energia = 100
	var property objetivo = nido

	var property position = new Position(x = 0, y = 0)

	method image() = if (self.fueAtrapado()) "pepita-gris.png" else "pepita.png"

	method fueAtrapado() = enemigo.position() == self.position()
	
	method irA(nuevaPosicion) {
		if (!self.terminoJuego()) {
			self.volar(nuevaPosicion.distance(position))
			position = nuevaPosicion
			//self.chequearEstadoDeJuego()
		}
	}

	method estaCansada() = energia <= 0

	method volar(kms) {
		energia = energia - 9 * kms
	}

	method llegoAlNido() = objetivo.position() == self.position()

	method terminoJuego() = self.estaCansada() || self.llegoAlNido()
	
	method comer(comida) {
		energia = energia + comida.energiaQueOtorga()
	}
	
	method perderAltura() {
		position = position.down(1)
	}
}

object silvestre {
	var property personajePrincipal = pepita

	method position() = new Position(x = personajePrincipal.position().x().max(3), y = 0)

	method image() = "silvestre.png"
}

object nido {
	method position() = game.center()

	method image() = "nido.png"
}

object manzana {
	var property position = new Position(x = 1.randomUpTo(3).roundUp(), y = 1.randomUpTo(3).roundUp())

	method image() = "manzana.png"
	
	method energiaQueOtorga() = 40
}

