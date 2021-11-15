import wollok.game.*

class Bloque {
	method tipo() {}
	method danio() {}
	method image()	
	method golpeado(tiro){}
}

class Limite inherits Bloque {

	override method image() = "ladrillo.jpeg"

}

class Camino inherits Bloque {

	override method image() = "piso2.png"

}

class ZonaConstruccion inherits Bloque {
	
	override method image() = "muro.png"
	
}
