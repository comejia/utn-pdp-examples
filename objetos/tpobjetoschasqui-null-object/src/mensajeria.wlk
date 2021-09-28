object chasqui {
	const longitudMaximaParaEnviarMensaje = 50
	
	method enviarMensaje(mensaje) = mensaje.length() < longitudMaximaParaEnviarMensaje

	method costoMensaje(mensaje) = mensaje.length() * 2

}

object sherpa {
	var costoPorMensaje = 60

	method enviarMensaje(mensaje) = self.tieneLongitudPar(mensaje)
	
	method tieneLongitudPar(mensaje) = (mensaje.length() % 2) == 0

	method costoMensaje(mensaje) = costoPorMensaje

	method cambiarCosto(nuevoCosto) {
		costoPorMensaje = nuevoCosto
	}

}

object messich {
	var costoBaseDeMensaje = 10

	method enviarMensaje(mensaje) = !mensaje.startsWith("a")

	method costoMensaje(mensaje) = mensaje.words().size() * costoBaseDeMensaje

	method cambiarCosto(nuevoCosto) {
		costoBaseDeMensaje = nuevoCosto
	}

}

object pali {
	const costoBaseDeMensaje = 4
	const costoMaximoPorMensaje = 80

	method esPalindromo(mensaje) {
		const mensajeSinEspacios = mensaje.replace(" ", "")
		return mensajeSinEspacios.equalsIgnoreCase(mensajeSinEspacios.reverse())
	}

	method enviarMensaje(mensaje) = self.esPalindromo(mensaje)

	method costoMensaje(mensaje) = (mensaje.length() * costoBaseDeMensaje).min(costoMaximoPorMensaje)

}


object agencia {
	const mensajeros = [chasqui, sherpa, messich, pali]

	method quienPuedeEnviarMensaje(mensaje) {
		const mensajerosQuePuedenEnviarMensaje = mensajeros.filter({ mensajero => mensajero.enviarMensaje(mensaje) })
		return mensajerosQuePuedenEnviarMensaje.fold(mensajerosQuePuedenEnviarMensaje.first(), 
			{ unMensajero, otroMensajero => if(unMensajero.costoMensaje(mensaje) < otroMensajero.costoMensaje(mensaje)) unMensajero else otroMensajero }
		)
	}

}

