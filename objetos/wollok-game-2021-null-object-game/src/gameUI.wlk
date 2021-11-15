import wollok.game.*
import monstruos.*
import bloques.*
import cursor.*
import torres.*
import recorridos.*
import tiros.*
import direcciones.*
import sonidos.*

object gameUI {
	// ordenamos en: rudo, rudo, debil, rudo, debil debil, rudo :)
	const monstruos = [
		new Agil(),
		new Elemental(), 
		new Loco(),
		new Fortachon(),
		new Agil(),
		new Fortachon(),
		new Elemental(),
		new Agil()
	]

	const limiteDeMonstruosQueAtraviezan = 5
	const limiteDeMonstruosEnPantalla = 2
	var monstruosQueAtravezaron = 0
	var monstruosEnPantalla = 0

	method configurar() {
		self.agregarGraficos()
		self.configurarEventos()
	}

	method configurarEventos() {
		self.iniciarAtaque(10000)
		self.configurarTiempoDeJuego(120000)
		self.avanceDeMonstruo(1000)
		self.configurarTeclado()
	}

	method agregarGraficos() {
		self.dibujarLimitesDeMapa()
		game.addVisual(menu)
		game.addVisual(submenu)
		game.addVisual(cursor)
		game.addVisual(estadoJuego)
		self.actualizarEstadoJuego()
	}

	method dibujarLimitesDeMapa() {
		cursor.limites().forEach({ pos => game.addVisualIn(new Limite(), pos) })
		recorrido.mapa().forEach({ pos => game.addVisualIn(new Camino(), pos) })
	}

	method configurarTeclado() {
		keyboard.up().onPressDo { cursor.mover(cursor.position().up(1)) }
		keyboard.down().onPressDo { cursor.mover(cursor.position().down(1)) }
		keyboard.left().onPressDo { cursor.mover(cursor.position().left(1)) }
		keyboard.right().onPressDo { cursor.mover(cursor.position().right(1)) }
		keyboard.c().onPressDo { self.construir() }
	}

	method construir() {
		if (cursor.validarPosicion()) {
			game.say(cursor, "Elegí una torre")
			keyboard.num1().onPressDo{ self.subMenu(new TorreBasica(position = cursor.position())) }
			keyboard.num2().onPressDo{ self.subMenu(new TorreMedia(position = cursor.position())) }
			keyboard.num3().onPressDo{ self.subMenu(new TorreAvanzada(position = cursor.position())) }
		} else {
			centralErrores.error("No podés construir aqui")
		}
	}

	method subMenu(torre) {
		game.say(cursor, "Seleccioná la dirección")
		keyboard.w().onPressDo{ torre.direccionTorre(arriba) }
		keyboard.s().onPressDo{ torre.direccionTorre(abajo) }
		keyboard.a().onPressDo{ torre.direccionTorre(izquierda) }
		keyboard.d().onPressDo{ torre.direccionTorre(derecha) }
		self.agregarTorre(torre)
	}
	
	method iniciarAtaque(tiempoDeInicio) {
		game.schedule(tiempoDeInicio, {
			self.generacionDeMonstruos(5000)
		})
	}

	method configurarTiempoDeJuego(tiempoDeJuego) {
		game.schedule(tiempoDeJuego, { self.ganar() })
	}

	method generacionDeMonstruos(tiempoGeneracionMonstruos) {
		game.onTick(tiempoGeneracionMonstruos, "generarMonstruos", {
			if (!self.seAlcanzoLimiteDeMonstruosEnPantalla()) {
				self.chequearEstadoJuego()
				self.agregarMonstruo()
			}
		})
	}

	method agregarMonstruo() {
		const monstruo = monstruos.findOrDefault({ 
			monstruo => !self.estaEnPantalla(monstruo)
		}, null)
		if (monstruo != null) {
			monstruosEnPantalla += 1
			game.addVisual(monstruo)
			//game.showAttributes(monstruo)			
		}
	}

	method avanceDeMonstruo(tiempoDeAvance) {
		game.onTick(tiempoDeAvance, "monstruoAvanza", {
			self.eliminarMonstruosSinFuerza()
			self.monstruosEnPantalla()
				.forEach( { monstruo => monstruo.avanzar()
					if (monstruo.llegoAlFinal()) {
						monstruosQueAtravezaron += 1
						self.eliminarMonstruo(monstruo)
						self.chequearEstadoJuego()
					}
				})
		})
	}

	method monstruosEnPantalla() = monstruos.filter({ monstruo => self.estaEnPantalla(monstruo) })

	method estaEnPantalla(monstruo) = game.hasVisual(monstruo)

	method chequearEstadoJuego() {	
		if (self.seAlcanzoLimiteDeCruce()) {
			self.perder()
		}
		if (self.noHayMonstruosParaAtacar()) {
			self.ganar()
		}
	}

	method eliminarMonstruosSinFuerza() {
		self.monstruosSinFuerza().forEach( { monstruo => self.eliminarMonstruo(monstruo) })
	}

	method monstruosSinFuerza() = monstruos.filter({ monstruo => monstruo.estaSinFuerza() })

	method seAlcanzoLimiteDeMonstruosEnPantalla() = 
		monstruosEnPantalla >= limiteDeMonstruosEnPantalla

	method seAlcanzoLimiteDeCruce() = 
		monstruosQueAtravezaron >= limiteDeMonstruosQueAtraviezan

	method noHayMonstruosParaAtacar() = monstruos.isEmpty()

	method eliminarMonstruo(monstruo) {
		game.removeVisual(monstruo)
		monstruos.remove(monstruo)
		monstruosEnPantalla -= 1
		self.actualizarEstadoJuego()
	}

	method perder() {
		self.finalizarJuego(15000, "PERDISTEEESSS!!")
		sonidos.derrota()
	}

	method ganar() {
		self.finalizarJuego(20000, "GANASTEEEEEE!!")
		sonidos.victoria()
	}
	
	method finalizarJuego(timeout, mensaje) {
		game.schedule(timeout, { game.stop() })
		mensajeFinal.mensaje(mensaje)
		game.addVisual(mensajeFinal)
		self.limitarMovimientos()		
	}

	method limitarMovimientos() {
		game.removeTickEvent("monstruoAvanza")
		game.removeTickEvent("generarMonstruos")
		game.removeTickEvent("disparar")
	}

	method agregarTorre(torre) {
		game.addVisual(torre)
		//game.showAttributes(torre)
		torre.disparar()
	}

	method actualizarEstadoJuego() {
		estadoJuego.actualizar(monstruosQueAtravezaron, monstruos.size())
	}
}

object centralErrores{
	method image() = "errores.png"
}

object mensajeFinal {
	var property text = "FIN JUEGO\n"
	method position() = game.center()
	method textColor() = paleta.blanco()

	method mensaje(mensaje) {
		text = text + mensaje
	}
}

object menu {
	method position() = new Position(x = 13, y = 13)
	method text() = "Tipo torre:\n1-TorreBasica\n2-TorreMedia\n3-TorreAvanzada"
	method textColor() = paleta.rojo()
}

object submenu {
	method position() = new Position(x = 16, y = 13)
	method text() = "Dirección:\nw-Arriba\na-Izquierda\ns-Abajo\nd-Derecha"
	method textColor() = paleta.verde()
}

object estadoJuego {
	var property text = ""
	method position() = new Position(x = 3, y = 13)
	method textColor() = paleta.blanco()

	method actualizar(cantidadQueAtravezaron, monstruosPorMatar) {
		text = "Estado juego:\n" + "Atravezaron: " + cantidadQueAtravezaron + "\nFalta por matar: " + monstruosPorMatar
	}

}

object paleta {
	const property blanco = "FFFFFF"
	const property verde = "00FF00FF"
	const property rojo = "FF0000FF"
	const property azul = "000000FF"
}
