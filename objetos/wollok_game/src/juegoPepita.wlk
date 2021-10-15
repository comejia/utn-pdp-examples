import wollok.game.*
import pepita.*

object pepitaUI {
	method configurarPersonajes() {
		game.addVisual(pepita) // como pepita se agrega primero, pasa por
									// detras de silvestre
		game.addVisual(silvestre)
		game.showAttributes(pepita)
		//game.showAttributes(manzana)
	}
	
	method configurarAccionesTeclado() {
		keyboard.left().onPressDo { pepita.irA(pepita.position().left(1)) }
		keyboard.right().onPressDo { pepita.irA(pepita.position().right(1)) }
		keyboard.up().onPressDo {  }
		keyboard.down().onPressDo {  }
		//keyboard.c().onPressDo { pepita.atraparComida() }
	}

	method configurarEventos() {
		game.onTick(800, "pepitaCae", { pepita.perderAltura() })	
	}

	method chequearEstadoDeJuego() {
		if (pepita.terminoJuego()) {
			game.removeTickEvent("pepitaCae")
		}
		if (pepita.estaCansada()) {
			game.sound("perdiste.wav").play()
			game.schedule(3000, { game.stop() })
		} 
		if (pepita.llegoAlNido()) {
			//game.removeVisual(objetivo)
			game.sound("ganaste.mp3").play()
			game.schedule(17000, { game.stop() })
		} 
	}
	
	method atraparComida() {
		const comidas = game.colliders(self)
		if (comidas.isEmpty()) throw new DomainException(message = "No hay nada para comer")
		const comida = comidas.first()
		pepita.comer(comida)
		game.removeVisual(comida)
	}
}
