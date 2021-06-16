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
    habilidades = habilidades persona ++ [carrera]
}

type ListaCiudades = [String]
viajarAListaDeCiudades :: ListaCiudades -> Suenio
viajarAListaDeCiudades ciudades persona = sumarFelicidonios (((* 100) . length) ciudades) persona {
    edad = ((+ 1) . edad) persona
}

enamorarseDeOtraPersona :: Persona -> Suenio
enamorarseDeOtraPersona otroPersona persona = sumarFelicidonios (felicidonios otroPersona) persona

queTodoSigaIgual :: Suenio
queTodoSigaIgual persona = persona

comboPerfecto :: Suenio
comboPerfecto = viajarAListaDeCiudades ["Berazategui", "Paris"] . recibirseDeUnaCarrera "Medicina" . sumarFelicidonios 100


-- Punto 4
cumplirEnesimoSuenio :: Number -> Suenio
cumplirEnesimoSuenio numeroDeSuenio persona =  (suenios persona !! (numeroDeSuenio-1)) persona

cumplirPrimerSuenio :: Suenio
cumplirPrimerSuenio = cumplirEnesimoSuenio 1

eliminarPrimerSuenio :: Persona -> Persona
eliminarPrimerSuenio persona = persona {suenios = (tail . suenios) persona}

type FuenteDeDeseos = Suenio

fuenteMinimalisa :: FuenteDeDeseos
fuenteMinimalisa = eliminarPrimerSuenio . cumplirPrimerSuenio

fuenteCopada :: FuenteDeDeseos
fuenteCopada persona
    | ((== 0) . cantidadDeSuenios) persona                      = persona
    | otherwise                                                 = (fuenteCopada . eliminarPrimerSuenio . cumplirPrimerSuenio) persona

fuenteAPedido :: Number -> FuenteDeDeseos
fuenteAPedido numSuenio = cumplirEnesimoSuenio numSuenio

fuenteSorda :: FuenteDeDeseos
fuenteSorda persona = persona


-- Punto 5
cantidadDeHabilidades :: Persona -> Number
cantidadDeHabilidades = length . habilidades

type Criterio = Persona -> Persona -> Bool

mayorCantidadFelicidonios :: Criterio
mayorCantidadFelicidonios persona1 persona2 = felicidonios persona1 > felicidonios persona2

menorCantidadFelicidonios :: Criterio
menorCantidadFelicidonios persona1 persona2 = felicidonios persona1 < felicidonios persona2

mayorCantidadHabilidades :: Criterio
mayorCantidadHabilidades persona1 persona2 = cantidadDeHabilidades persona1 > cantidadDeHabilidades persona2

fuenteGanadora :: [FuenteDeDeseos] -> Persona -> Criterio -> FuenteDeDeseos
fuenteGanadora [unaFuente] _ _ = unaFuente
fuenteGanadora (primerFuente:segundaFuente:restoDeFuentes) persona criterio
    | criterio (primerFuente persona) (segundaFuente persona)                          = fuenteGanadora (primerFuente:restoDeFuentes) persona criterio
    | otherwise                                                                        = fuenteGanadora (segundaFuente:restoDeFuentes) persona criterio


-- Punto 6
felicidoniosDeSuenioCumplido :: Persona -> Suenio -> Number
felicidoniosDeSuenioCumplido persona suenio = (felicidonios . suenio) persona

sueniosValiosos :: Persona -> [Suenio]
sueniosValiosos persona = filter ((> 100) . felicidoniosDeSuenioCumplido persona) (suenios persona)

algunSuenioRaro :: Persona -> Bool
algunSuenioRaro persona = any ((== felicidonios persona) . felicidoniosDeSuenioCumplido persona) (suenios persona)

felicidadDelGrupo :: [Persona] -> Number
felicidadDelGrupo grupo = foldr ((+) . flip (felicidoniosDeSuenioCumplido) fuenteCopada) 0 grupo
--felicidadDelGrupo grupo = foldl (\totalFelicidonios persona -> totalFelicidonios + felicidoniosDeSuenioCumplido persona fuenteCopada) 0 grupo
