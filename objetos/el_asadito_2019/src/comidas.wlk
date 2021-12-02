class Comida {
	var property esCarne = false
	var property calorias = 100

	method esPesada() = calorias > 500
}

object pechitoDeCerdo inherits Comida(esCarne = true, calorias = 270) {

}

object albondigas inherits Comida(esCarne = true, calorias = 550) {

}

object ensalada inherits Comida(esCarne = false, calorias = 50) {

}