object chasqui {
	const longitudMaximaParaEnviarMensaje = 50

	method puedeEnviarMensaje(mensaje) = mensaje.length() < longitudMaximaParaEnviarMensaje

	method costoMensaje(mensaje) = mensaje.length() * 2

}

object sherpa {
	var property costoPorMensaje = 60

	method puedeEnviarMensaje(mensaje) = self.tieneLongitudPar(mensaje)

	method tieneLongitudPar(mensaje) = mensaje.length().even()

	method costoMensaje(mensaje) = costoPorMensaje

}

object messich {
	var property costoBaseDeMensaje = 10

	method puedeEnviarMensaje(mensaje) = !mensaje.startsWith("a")

	method costoMensaje(mensaje) = mensaje.words().size() * costoBaseDeMensaje

}

object pali {
	const costoBaseDeMensaje = 4
	const costoMaximoPorMensaje = 80

	method esPalindromo(mensaje) {
		const mensajeSinEspacios = mensaje.replace(" ", "")
		return mensajeSinEspacios.equalsIgnoreCase(mensajeSinEspacios.reverse())
	}

	method puedeEnviarMensaje(mensaje) = self.esPalindromo(mensaje)

	method costoMensaje(mensaje) = (mensaje.length() * costoBaseDeMensaje).min(costoMaximoPorMensaje)

}

object random {
	method numeroAleatorio() = 3.randomUpTo(7).roundUp()
}

object pichca {
	var property costoBaseDeMensaje = random

	method puedeEnviarMensaje(mensaje) = mensaje.words().size() > 3

	method costoMensaje(mensaje) = mensaje.length() * costoBaseDeMensaje.numeroAleatorio()
	// Para testear este mensaje, una forma es usando objetos anonimos
}


class MensajeroEstandar {
	const longitudMinimaParaEnviarMensaje = 20
	var property sector

	method puedeEnviarMensaje(mensaje) = mensaje.length() >= longitudMinimaParaEnviarMensaje

	method costoMensaje(mensaje) = mensaje.words().size() * sector.costoSector()

}

class Sector {
	var property costoSector
}

