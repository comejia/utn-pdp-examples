/** First Wollok example */
object nico {
	method cuantoCobra(materia) = materia.length() * 50
	
	method leCaeBien(alumno) = alumno.estudia("fisica") 
}

object carlono {
	var precio = 300

	method precio(nuevoPrecio) {
		precio = nuevoPrecio
	}

	method cuantoCobra(materia) = precio
	
	method leCaeBien(alumno) = true
}

object camila {
	var gradoAlegria = 7
	
	method encularse() {
		gradoAlegria = gradoAlegria + 1
	}
	
	method alegrarse() {
		gradoAlegria = gradoAlegria - 1
	}
	
	method estaDeBuenHumor() = gradoAlegria >= 7

	method cuantoCobra(materia) = if (self.estaDeBuenHumor()) 250 else 750
}

object lucas {
	const materias = ["historia", "matematicas", "fisica"]

	var plata = 400
	var profePreferido = nico

	method materiasQueEstudia() = materias

	method estudia(materia) = materias.contains(materia)

	method estudiaMucho() = materias.size() > 3
	
	method profePreferido(nuevoProfePreferido) {
		profePreferido = nuevoProfePreferido
	}
	
	method estaFeliz() = profePreferido.cuantoCobra("geografia") <= plata
}

object melanie {
	
	method estudia(materia) = false

	method estudiaMucho() = true
	
}

