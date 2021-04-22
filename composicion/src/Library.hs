module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

-- Ejemplo: saber si el siguiente numero es par
siguiente :: Number -> Number
siguiente numero = numero + 1

siguienteEsPar :: Number -> Bool
--siguienteEsPar numero = (even . siguiente) numero
siguienteEsPar = even . siguiente -- notacion point free


-- Ejemplo: saber si una persona es mayor de edad
type Nombre = String -- hace mas descriptivo
type Edad = Number
type Domicilio = String
type Persona = (Nombre, Edad, Domicilio) -- tupla

clara :: Persona
clara = ("Clara", 27, "Calle falsa 123")

edad :: Persona -> Edad
--edad = snd
edad (_, _edad, _) = _edad -- utilizando pattern maching

mayorEdad :: Edad -> Bool
mayorEdad edad = edad >= 18

esMayorDeEdad :: Persona -> Bool
esMayorDeEdad persona = (mayorEdad . edad) persona
--esMayorDeEdad  = mayorEdad . edad


-- Ejemplo: saber si una persona empieza con 'c'
nombre :: Persona -> Nombre
nombre (_nombre, _, _) = _nombre

primerElemento :: Nombre -> Char
primerElemento = head

empiezaConC :: Persona -> Bool
empiezaConC persona = (primerElemento . nombre) persona == 'C'