class EspacioUrbano {
	var property valuacion = 1000
	var property superficie = 100
	var property nombre = ""	
	var property tieneVallado = false

	method esGrande() = self.superficie() > 50 && self.condicionDeGrande()

	method condicionDeGrande()

	method esEspacioVerde() = false

	method esEspacioLimpiable() = false

	method aumentarValor(montoAAumentar){
		valuacion = valuacion + montoAAumentar
	}

}

class Plaza inherits EspacioUrbano {
	var property canchas

	override method condicionDeGrande() = canchas > 2

	override method esEspacioVerde() = canchas == 0

	override method esEspacioLimpiable() = true
}

class Plazoleta inherits EspacioUrbano {
	var property procer

	override method condicionDeGrande() = procer == "San Martin" && self.tieneVallado()
}

class Anfiteatro inherits EspacioUrbano {
	var property capacidad

	override method condicionDeGrande() = capacidad > 500

	override method esEspacioLimpiable() = self.esGrande()
}

class Multiespacio inherits EspacioUrbano {
	var property espaciosUrbanos = []

	override method condicionDeGrande() = espaciosUrbanos.all{ espacio => espacio.esGrande() }

	override method esEspacioVerde() = espaciosUrbanos.size() > 3
}

