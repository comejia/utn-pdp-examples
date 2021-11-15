object arriba {

	method move(objeto) {
		objeto.position(objeto.position().up(1))
	}

}

object derecha {

	method move(objeto) {
		objeto.position(objeto.position().right(1))
	}

}

object izquierda {

	method move(objeto) {
		objeto.position(objeto.position().left(1))
	}

}

object abajo {

	method move(objeto) {
		objeto.position(objeto.position().down(1))
	}

}