import wollok.game.*
import torres.*

class Tiro {

	var property direccion
	var property image = "tiro.png"
	var property position
	var property danio

	method disparada() {
		game.addVisual(self)
		game.onTick(500, "moverTiro" + self.identity(), { direccion.move(self) })
		self.colisiones()
	}

	method colisiones() {
		game.onCollideDo(self, { objetoQueColisiona => objetoQueColisiona.golpeado(self) })
	}

	method remover() {
		game.removeTickEvent("moverTiro" + self.identity())
		game.removeVisual(self)
	}

	method avanzar() {
		position = direccion.nuevaPosition(self)
	}

	method golpeado(tiro) {
	}

}

