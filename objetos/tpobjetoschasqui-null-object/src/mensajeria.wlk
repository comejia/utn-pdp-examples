import mensajeras.*

class UserException inherits Exception {}

object calendarioActual {
	method fechaDeHoy() = new Date()
}

object agencia {
	const mensajeros = [chasqui, sherpa, messich, pali]
	const historial = []
	var property calendario = calendarioActual

	method mensajerosQuePuedenEnviar(mensaje) = mensajeros.filter({ mensajero => mensajero.puedeEnviarMensaje(mensaje) })

	method quienPuedeEnviarMensaje(mensaje) = self.mensajerosQuePuedenEnviar(mensaje) 
			.min({ mensajero => mensajero.costoMensaje(mensaje) })

	method recibirMensaje(mensaje) {
		if (mensaje.isEmpty()) {
			 throw new UserException(message = "El mensaje no puede estar vacio")
		}

		if (self.mensajerosQuePuedenEnviar(mensaje).isEmpty()) {
			throw new UserException(message = "No hay mensajero que pueda enviar el mensaje")
		}

		const mensajeroElegido = self.quienPuedeEnviarMensaje(mensaje)

		self.agregarAlHistorial(new Envio(fechaDeEnvio = calendario.fechaDeHoy(), mensaje = mensaje, mensajero = mensajeroElegido))
	}

	method agregarAlHistorial(envio) {
		historial.add(envio)
	}

	method gananciaNetaDelMes() =
		self.historialDelUltimoMes().sum({ envio => self.costoMensaje(envio.mensaje()) - envio.costoEnvio() })

	method historialDelUltimoMes() = historial.filter({ envio => self.esDelUltimoMes(envio) })

	method costoMensaje(mensaje) = if (mensaje.length() < 30) 500 else 900

	method esDelUltimoMes(envio) = (calendario.fechaDeHoy() - envio.fechaDeEnvio()) <= 30

	method chasquiQuilla() =
		self.empleadosDelUltimoMes().asSet().max({ empleado => self.empleadosDelUltimoMes().occurrencesOf(empleado) })

	method empleadosDelUltimoMes() = self.historialDelUltimoMes().map({ envio => envio.mensajero() })

}

class Envio {
	var property fechaDeEnvio
	var property mensaje
	var property mensajero

	method costoEnvio() = mensajero.costoMensaje(mensaje)
}
