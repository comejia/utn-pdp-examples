module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

-- Modelado del ejecicio del apunte

data Parcial = Parcial {
    nombreDeLaMateria :: String,
    cantidadDePreguntas :: Number
} deriving (Show)

type Dia = Number
type Mes = Number
type Anio = Number
type Fecha = (Dia, Mes, Anio)

data Alumno = Alumno {
    nombre :: String,
    fechaDeNacimiento :: Fecha,
    legajo :: Number,
    materiasQueCursa :: [String],
    criterioDeEstudio :: CriterioDeEstudio
} deriving (Show)

type CriterioDeEstudio = Parcial -> Bool

estudioso :: CriterioDeEstudio
estudioso _ = True

hijoDelRigor :: Number -> CriterioDeEstudio
hijoDelRigor preguntasLimite = (> preguntasLimite) . cantidadDePreguntas

cabuleros :: CriterioDeEstudio
cabuleros = odd . length . nombreDeLaMateria

nico :: Alumno
nico = Alumno {
    nombre = "Nico",
    fechaDeNacimiento = (10,10,1987),
    materiasQueCursa = ["pdp", "so"],
    criterioDeEstudio = estudioso,
    legajo = 1418713
}

cambiarCriterioDeEstudio :: CriterioDeEstudio -> Alumno -> Alumno
cambiarCriterioDeEstudio nuevoCriterio alumno = alumno {
    criterioDeEstudio = nuevoCriterio
}

parcialPdP = Parcial {
    nombreDeLaMateria = "PdP",
    cantidadDePreguntas = 2
}

estudia :: Parcial -> Alumno -> Bool
estudia parcial alumno = (criterioDeEstudio alumno) parcial
