module Library where
import PdePreludat


-- Punto 1a
type Recurso = String

data Pais = Pais {
    ipc :: Number,
    poblacionSectorPublico :: Number,
    poblacionSectorPrivado :: Number,
    recursos :: [Recurso],
    deuda :: Number
} deriving (Show, Eq)

-- Punto 1b
namibia :: Pais
namibia = Pais 4140 400000 650000 ["Mineria", "Ecoturismo"] 50000000


-- Punto 2
reducirSectorPublico :: Number -> Pais -> Pais
reducirSectorPublico puestosAReducir pais = pais { poblacionSectorPublico = poblacionSectorPublico pais - puestosAReducir }

poblacionActiva :: Pais -> Number
poblacionActiva pais = poblacionSectorPublico pais + poblacionSectorPrivado pais

reducirIPC :: Pais -> Pais
reducirIPC pais
    | poblacionActiva pais > 100       = pais { ipc = ipc pais * 0.8 }
    | otherwise                         = pais { ipc = ipc pais * 0.85 }

modificarDeuda :: Number -> Pais -> Pais
modificarDeuda dinero pais = pais { deuda = deuda pais + dinero}

quitarRecurso :: Recurso -> Pais -> Pais
quitarRecurso recurso pais = pais { recursos = (filter (/= recurso) . recursos) pais }

productoBrutoInterno :: Pais -> Number
productoBrutoInterno pais = ipc pais * poblacionActiva pais + poblacionActiva pais

type Estrategia = Pais -> Pais

prestarMillonesDeDolares :: Number -> Estrategia
prestarMillonesDeDolares prestamo = modificarDeuda (prestamo * 1.5)

redudirPuestosEnSectorPublico :: Number -> Estrategia
redudirPuestosEnSectorPublico puestosAReducir = reducirIPC . reducirSectorPublico puestosAReducir

darAlgunRecursoNatural :: Recurso -> Estrategia
darAlgunRecursoNatural recurso = quitarRecurso recurso . modificarDeuda (-2000000)

establecerUnBlindaje :: Estrategia
establecerUnBlindaje pais = (modificarDeuda (productoBrutoInterno pais / 2) . reducirSectorPublico 500) pais


-- Punto 3a
type Receta = [Estrategia]

receta :: Receta
receta = [prestarMillonesDeDolares 200000000, darAlgunRecursoNatural "Mineria"]

-- Punto 3b
aplicarReceta :: Receta -> Pais -> Pais
aplicarReceta receta pais = foldr ($) pais receta

-- No hay efecto colateral! el objeto que se obtiene al aplicar la receta es distinto al original


-- Punto 4a
paisesQuePuedenZafar :: [Pais] -> [Pais]
paisesQuePuedenZafar paises = filter (any (== "Petroleo") . recursos ) paises

-- Punto 4b
deudaTotalAFavorDelFMI :: [Pais] -> Number
deudaTotalAFavorDelFMI = foldr ((+) . deuda) 0
deudaTotalAFavorDelFMI' = sum . map (deuda)

-- Punto 4c
-- Orden superior aparece en los dos puntos al usar funciones como filter, foldr
-- Ejemplo de composicion y aplicacion parcial: any (== "Petroleo") . recursos


-- Punto 5
