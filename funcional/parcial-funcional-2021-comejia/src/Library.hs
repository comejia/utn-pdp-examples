module Library where
import PdePreludat

-- César Mejía
-- NOTA: 10 (diez)

-- Dominio
type Tipo = String
type Potencios = Number
type Defensios = Number
type Batallon = [Unidad]

data Unidad = Unidad {
    tipoDeUnidad :: Tipo,
    nivelDeAtaque :: Potencios,
    herramientas :: [Herramienta]
} deriving (Show)

data Herramienta = Herramienta {
    -- era potencio
    pontencio :: Potencios
} deriving (Show)

data Ciudad = Ciudad {
    nombreCiudad :: String,
    nivelDeDefensa :: Defensios,
    batallon :: Batallon,
    sistemasDeDefensa :: [SistemaDeDefensa]
} deriving (Show)


-- Punto 1
-- CORRECCION: 3 puntos
tiposDeUnidadesGrosas :: Ciudad -> [Tipo]
tiposDeUnidadesGrosas = map (tipoDeUnidad) . filter ((> 160) . nivelDeAtaque) . batallon

ciudadConAtaquePoderoso :: Ciudad -> Bool
ciudadConAtaquePoderoso = all ((> 100) . nivelDeAtaque) . take 3 . batallon

nivelQueAportanLasHerramientas :: Unidad -> Potencios
nivelQueAportanLasHerramientas = foldr ((+) . pontencio) 0 . herramientas


-- Punto 2
-- CORRECCION: 2 puntos

nivelTotalDeAtaque :: Unidad -> Potencios
nivelTotalDeAtaque unidad = nivelDeAtaque unidad + nivelQueAportanLasHerramientas unidad

poderOfensivo :: Unidad -> Potencios
poderOfensivo unidad
    | ((> 5) . length . herramientas) unidad            = 100 + nivelTotalDeAtaque unidad
    | ((== "caballeria") . tipoDeUnidad) unidad         = 2 * nivelTotalDeAtaque unidad
    | otherwise                                         = nivelTotalDeAtaque unidad


-- Punto 3
-- CORRECCION: 2 puntos

batallonSobreviveAtaque :: Batallon -> Batallon -> Bool
batallonSobreviveAtaque batallonDefensivo [] = True
batallonSobreviveAtaque [] batallonRival = False
batallonSobreviveAtaque (defensa:defensas) (rival:rivales)
    | poderOfensivo defensa >= poderOfensivo rival                  = batallonSobreviveAtaque (defensa:defensas) rivales
    | otherwise                                                     = batallonSobreviveAtaque defensas (rival:rivales)


-- Punto 4
-- CORRECCION: 3 puntos

incrementarNivelDefensa :: Defensios -> Ciudad -> Ciudad
incrementarNivelDefensa defensios ciudad = ciudad { nivelDeDefensa = nivelDeDefensa ciudad + defensios }

incrementarNivelAtaqueBatallon :: Potencios -> Ciudad -> Ciudad
incrementarNivelAtaqueBatallon cantidadAtaque ciudad = ciudad { batallon = map (incrementarNivelAtaqueUnidad cantidadAtaque) $ batallon ciudad }

incrementarNivelAtaqueUnidad :: Potencios -> Unidad -> Unidad
incrementarNivelAtaqueUnidad cantidadAtaque unidad = unidad { nivelDeAtaque = nivelDeAtaque unidad + cantidadAtaque}

type SistemaDeDefensa = Ciudad -> Ciudad

muralla :: Number -> SistemaDeDefensa
muralla altura ciudad = incrementarNivelDefensa (3 * altura) ciudad { nombreCiudad = "La gran ciudad de " ++ nombreCiudad ciudad }

torreDeVigilancia :: SistemaDeDefensa
torreDeVigilancia = incrementarNivelDefensa 40

centroDeEntrenamiento :: Potencios -> SistemaDeDefensa
centroDeEntrenamiento cantidadAtaque = incrementarNivelDefensa 10 . incrementarNivelAtaqueBatallon cantidadAtaque

instalarBancos :: SistemaDeDefensa
instalarBancos ciudad = ciudad


-- Punto 5
-- CORRECCION: 2,75 puntos
-- Faltó indicar cómo se invoca desde la consola
poderDefensivo :: Ciudad -> Defensios
poderDefensivo ciudad = (foldr ((+) . nivelDeDefensa . ($ ciudad)) 0 . sistemasDeDefensa) ciudad

persepolis :: Ciudad
persepolis = Ciudad "Persepolis" 10 [] [muralla 5, centroDeEntrenamiento 15, torreDeVigilancia]


-- Punto 6
-- CORRECCION: 1 punto

ciudadSobreviveAtaque :: Ciudad -> Batallon -> Bool
ciudadSobreviveAtaque ciudad batallonAtacante 
    = batallonSobreviveAtaque (batallon ciudad) batallonAtacante || poderDefensivo ciudad > poderOfensivoBatallon batallonAtacante

poderOfensivoBatallon :: Batallon -> Potencios
poderOfensivoBatallon = foldr ((+) . poderOfensivo) 0


-- Punto 7
-- CORRECCION: 1 punto

ciudadConBatallonInfinito :: Ciudad
ciudadConBatallonInfinito = Ciudad "InvenCible" 1000 (repeat (Unidad "Guerrero" 100 [])) []

-- No es posible solicitar los tipos de unidades grosas porque el algoritmo diverge, ya que nunca termina de evaluar al batallon.

-- Por el contrario, sí se puede saber si una ciudad tiene ataque poderoso ya que solo se evaluan las primeras 3 unidades. Ésto está
-- relacionaDO con el concepto de "evaluacion diferida", solo se evalúa lo que se necesita

