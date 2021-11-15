import tiros.*
import monstruos.*
import wollok.game.*
import direcciones.*

class Torres {

	var property position
	var property direccionTorre = arriba
	var property posicionVariable = true
	var property danioTorre

	method disparar()

	method direccionTorre(nuevaDireccion) {
		if (self.posicionVariable()) {
			direccionTorre = nuevaDireccion
			posicionVariable = false
		}
	}

	method image()

	method golpeado(tiro) {
	}

}

class TorreBasica inherits Torres(danioTorre = 10) {

	override method disparar() {
		game.onTick(3000, "disparar", { 
			const tiro = new Tiro(direccion = direccionTorre, danio = danioTorre, position = self.position())
			tiro.disparada()
		})
	}

	override method image() = "torreBasica.png"

}

class TorreMedia inherits Torres(danioTorre = 30) {

	override method disparar() {
		game.onTick(3000, "disparar", { 
			const tiro = new Tiro(direccion = direccionTorre, danio = danioTorre, position = self.position())
			tiro.disparada()
		})
	}

	override method image() = "torreMedia.png"

}

class TorreAvanzada inherits Torres(danioTorre = 50) {

	override method disparar() {
		game.onTick(3000, "disparar", { 
			const tiro = new Tiro(direccion = direccionTorre, danio = danioTorre, position = self.position())
			tiro.disparada()
		})
	}

	override method image() = "torreAvanzada.png"

}

