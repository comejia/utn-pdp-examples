module Library where
import PdePreludat

-- Dominio
data Persona = Persona {
    edad :: Number,
    suenios :: [Suenio],
    nombre :: String,
    felicidonios :: Number,
    habilidades :: [String]
} deriving (Show)


-- Punto 1
cantidadDeSuenios :: Persona -> Number
cantidadDeSuenios = length . suenios

coeficienteDeSatisfaccion :: Persona -> Number
coeficienteDeSatisfaccion persona
    | felicidonios persona > 100                    = felicidonios persona * edad persona
    | felicidonios persona > 50                     = cantidadDeSuenios persona * felicidonios persona
    | otherwise                                     = div (felicidonios persona) 2

gradoDeAmbicion :: Persona -> Number
gradoDeAmbicion persona
    | felicidonios persona > 100                    = felicidonios persona * cantidadDeSuenios persona
    | felicidonios persona > 50                     = edad persona * cantidadDeSuenios persona
    | otherwise                                     = cantidadDeSuenios persona * 2


-- Punto 2
nombreLargo :: Persona -> Bool
nombreLargo = (> 10) . length . nombre

personaSuertuda :: Persona -> Bool
personaSuertuda = even . (* 3) . coeficienteDeSatisfaccion

nombreLindo :: Persona -> Bool
nombreLindo = (== 'a') . last . nombre


-- Punto 3
type Suenio = Persona -> Persona

sumarFelicidonios :: Number -> Suenio
sumarFelicidonios felicidoniosASumar persona = persona {
    felicidonios = felicidonios persona + felicidoniosASumar
}

type Carrera = String
recibirseDeUnaCarrera :: Carrera -> Suenio
recibirseDeUnaCarrera carrera persona = sumarFelicidonios (((* 1000) . length) carrera) persona {
    --felicidonios = felicidonios persona + ((* 1000) . length) carrera,
    habilidades = habilidades persona ++ [carrera]
}

type ListaCiudades = [String]
viajarAListaDeCiudades :: ListaCiudades -> Suenio
viajarAListaDeCiudades ciudades persona = sumarFelicidonios (((* 100) . length) ciudades) persona {
    --felicidonios = felicidonios persona + ((* 100) . length) ciudades,
    edad = ((+ 1) . edad) persona
}

enamorarseDeOtraPersona :: Persona -> Suenio
enamorarseDeOtraPersona otroPersona persona = sumarFelicidonios (felicidonios otroPersona) persona

queTodoSigaIgual :: Suenio
queTodoSigaIgual persona = persona

comboPerfecto :: Suenio
comboPerfecto = viajarAListaDeCiudades ["Berazategui", "Paris"] . recibirseDeUnaCarrera "Medicina" . sumarFelicidonios 100
