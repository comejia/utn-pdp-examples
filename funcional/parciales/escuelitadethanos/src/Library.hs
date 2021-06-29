module Library where
import PdePreludat


-- Punto 1
type Material = String

data Guantelete = Guantelete {
    material :: Material,
    gemas :: Number
} deriving(Show)

type Habilidad = String

data Personaje = Personaje {
    nombre :: String,
    edad :: Number,
    energia :: Number,
    habilidades :: [Habilidad],
    planeta :: String
} deriving(Show)

data Universo = Universo {
    habitantes :: [Personaje]
} deriving(Show)


guanteleteCompleto :: Guantelete -> Bool
guanteleteCompleto guantelete = gemas guantelete == 6 && material guantelete == "uru" 

cantidadDeHabitantes :: Universo -> Number
cantidadDeHabitantes = length . habitantes

reducirHabitantes :: Universo -> Universo
reducirHabitantes universo = universo { habitantes = take (div (cantidadDeHabitantes universo) 2) (habitantes universo)}

chasquido :: Guantelete -> Universo -> Universo
chasquido guantelete universo
    | guanteleteCompleto guantelete             = reducirHabitantes universo
    | otherwise                                 = universo


-- Punto 2
aptoParaPendex :: Universo -> Bool
aptoParaPendex = any ((< 45) . edad) . habitantes

personajesConVariasHabilidades :: Universo -> [Personaje]
personajesConVariasHabilidades = filter ((> 1) . length . habilidades) . habitantes

energiaTotal :: Universo -> Number
energiaTotal universo = foldr ((+) . energia) 0 (personajesConVariasHabilidades universo)


