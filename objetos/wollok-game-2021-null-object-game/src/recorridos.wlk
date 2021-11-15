import wollok.game.*

object recorrido {
	const property mapa = [
		new Position(x = 1, y = 7),
		new Position(x = 2, y = 7),
		new Position(x = 3, y = 7),
		new Position(x = 4, y = 7),
		new Position(x = 5, y = 7),
		new Position(x = 6, y = 7),
		new Position(x = 7, y = 7),
		new Position(x = 8, y = 7),
		new Position(x = 9, y = 7),
		new Position(x = 9, y = 6),
		new Position(x = 9, y = 5),
		new Position(x = 10, y = 5),
		new Position(x = 11, y = 5),
		new Position(x = 12, y = 5),
		new Position(x = 13, y = 5),
		new Position(x = 14, y = 5),
		new Position(x = 15, y = 5),
		new Position(x = 16, y = 5),
		new Position(x = 17, y = 5)
	]

	method posicionInicial() = mapa.first()

	method posicionFinal() = mapa.last()

	method siguientePosicion(monstruo) {
		if(monstruo.position() == self.posicionFinal()) {
			return self.posicionFinal()	
		}
		var indice = 0
		var posicionActual
		mapa.forEach({ pos =>
			if(pos == monstruo.position())
				posicionActual = indice
			indice += 1
		})
		return mapa.get(posicionActual + 1)
	}

	method posicionAleatoria() = mapa.anyOne()

}