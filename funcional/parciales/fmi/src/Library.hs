module Library where
import PdePreludat


-- Punto 1a
type Recurso = String

data Pais = Pais {
    ingresoPerCapita :: Number,
    activosPublico :: Number,
    activosPrivado :: Number,
    recursos :: [Recurso],
    deuda :: Number
} deriving (Show, Eq)

-- Punto 1b
namibia :: Pais
namibia = Pais 4140 400000 650000 ["Mineria", "Ecoturismo"] 50


-- Punto 2
reducirSectorPublico :: Number -> Pais -> Pais
reducirSectorPublico puestosAReducir pais = pais { activosPublico = activosPublico pais - puestosAReducir }

poblacionActiva :: Pais -> Number
poblacionActiva pais = activosPublico pais + activosPrivado pais

reducirIPC :: Number -> Pais -> Pais
reducirIPC puestos pais
    | puestos > 100                 = pais { ingresoPerCapita = ingresoPerCapita pais * 0.8 }
    | otherwise                     = pais { ingresoPerCapita = ingresoPerCapita pais * 0.85 }

modificarDeuda :: Number -> Pais -> Pais
modificarDeuda dinero pais = pais { deuda = deuda pais + dinero}

quitarRecurso :: Recurso -> Pais -> Pais
quitarRecurso recurso pais = pais { recursos = (filter (/= recurso) . recursos) pais }

productoBrutoInterno :: Pais -> Number
productoBrutoInterno pais = ingresoPerCapita pais * poblacionActiva pais

type Estrategia = Pais -> Pais

prestarMillonesDeDolares :: Number -> Estrategia
prestarMillonesDeDolares prestamo = modificarDeuda (prestamo * 1.5)

reducirPuestosEnSectorPublico :: Number -> Estrategia
reducirPuestosEnSectorPublico puestosAReducir = reducirIPC puestosAReducir . reducirSectorPublico puestosAReducir

darAlgunRecursoNatural :: Recurso -> Estrategia
darAlgunRecursoNatural recurso = quitarRecurso recurso . modificarDeuda (-20)

establecerBlindaje :: Estrategia
establecerBlindaje pais = (prestarMillonesDeDolares (productoBrutoInterno pais * 0.5) . reducirPuestosEnSectorPublico 500) pais


-- Punto 3a
type Receta = [Estrategia]

receta :: Receta
receta = [prestarMillonesDeDolares 200, darAlgunRecursoNatural "Mineria"]

-- Punto 3b
aplicarReceta :: Pais -> Receta -> Pais
aplicarReceta = foldr ($)
-- No hay efecto colateral! el objeto/pais que se obtiene al aplicar la receta es distinto al original


-- Punto 4a
paisesQuePuedenZafar :: [Pais] -> [Pais]
paisesQuePuedenZafar paises = filter (any (== "Petroleo") . recursos) paises

-- Punto 4b
deudaTotalAFavorDelFMI :: [Pais] -> Number
deudaTotalAFavorDelFMI = foldr ((+) . deuda) 0
deudaTotalAFavorDelFMI' = sum . map (deuda)

-- Punto 4c
-- Orden superior aparece en los dos puntos al usar funciones como filter, foldr
-- Ejemplo de composicion y aplicacion parcial: any (== "Petroleo") . recursos


-- Punto 5
listaDeRecetaOrdenada :: Pais -> [Receta] -> Bool
listaDeRecetaOrdenada _ [unaReceta] = True
listaDeRecetaOrdenada pais (receta1:receta2:recetas)
    | (productoBrutoInterno . aplicarReceta pais) receta1 <= (productoBrutoInterno . aplicarReceta pais) receta2        = listaDeRecetaOrdenada pais (receta2:recetas)
    | otherwise                                                                                                         = False


-- Punto 6
recursosNaturalesInfinitos :: [Recurso]
recursosNaturalesInfinitos = "Energia" : recursosNaturalesInfinitos

paisConRecursosInfinitos :: Pais
paisConRecursosInfinitos = Pais 4140 400000 650000 recursosNaturalesInfinitos 50

-- Punto 6a
-- El algoritmo diverge ya que nunca termina al buscar "Mineria"
-- Punto 6b
-- En este caso no hay problemas ya que se evalua la deuda de un pais
-- Esta relacionado con evaluacion diferida, solo se evalua lo que se necesita

