import wollok.game.*

object sonidos {
	
	method reproducir(sonido) {
		sonido.play()
	}

	method inicio() {
		self.reproducir(game.sound("inicio1.mp3"))
	}

	method batalla() {
		self.reproducir(game.sound("Batalla1.mp3"))
	}

	method victoria() {
		self.reproducir(game.sound("Victoria3.mp3"))
	}

	method derrota() {
		self.reproducir(game.sound("Derrota.mp3"))
	}

	method enemigoMuere() {
		self.reproducir(game.sound("GritoMonstruoMuerto.mp3"))
	}

	method enemigoRecibeDanio() {
		self.reproducir(game.sound("RuidoPorImpacto.mp3"))
	}

	method tiro() {
		self.reproducir(game.sound("tiro.mp3"))
	}

	method construccion() {
		self.reproducir(game.sound("Construccion.mp3"))
	}

}
	