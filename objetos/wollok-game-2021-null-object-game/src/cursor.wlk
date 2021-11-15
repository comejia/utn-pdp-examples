import wollok.game.*
import monstruos.*
import recorridos.*

object cursor {
	var property seleccionInicio = []
	var property limites = [game.at(0,9),game.at(1,9),game.at(2,9),game.at(3,9),game.at(4,9),game.at(5,9),game.at(6,9),game.at(7,9),game.at(8,9),game.at(9,9),game.at(10,9),
							game.at(10,8),
							game.at(11,7),game.at(12,7),game.at(13,7),game.at(14,7),game.at(15,7),game.at(16,7),game.at(17,7),
							game.at(18,6),
							game.at(18,5),
							game.at(18,4),
							game.at(18,3),game.at(17,3),game.at(16,3),game.at(15,3),game.at(14,3),game.at(13,3),game.at(12,3),game.at(11,3),game.at(10,3),game.at(9,3),
							game.at(8,4),game.at(7,5),game.at(6,5),game.at(5,5),game.at(4,5),game.at(3,5),game.at(2,5),game.at(1,5),game.at(0,5),game.at(0,6),game.at(0,7),game.at(0,8)]

	var property position = game.at(17,4)

	method golpeado(tiro) {}

	method mover(posicionNueva){
		if(!limites.contains(posicionNueva)) {
			self.position(posicionNueva)
		}
	}

	method validarPosicion() { 
		return !recorrido.mapa().any({ pos => pos == self.position() }) 
	}

	method image() = "cursor.png"

}
