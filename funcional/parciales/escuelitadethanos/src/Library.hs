module Library where
import PdePreludat


-- Punto 1
type Material = String

data Guantelete = Guantelete {
    material :: Material,
    gemas :: [Gema]
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

cantidadDeGemas :: Guantelete -> Number
cantidadDeGemas = length . gemas

cantidadDeHabitantes :: Universo -> Number
cantidadDeHabitantes = length . habitantes

guanteleteCompleto :: Guantelete -> Bool
guanteleteCompleto guantelete = ((== 6) . cantidadDeGemas) guantelete && ((== "uru") . material) guantelete 

reducirHabitantes :: Universo -> Universo
reducirHabitantes universo = universo { habitantes = take (cantidadDeHabitantes universo `div` 2) (habitantes universo)}

chasquido :: Guantelete -> Universo -> Universo
chasquido guantelete universo
    | guanteleteCompleto guantelete             = reducirHabitantes universo
    | otherwise                                 = universo


-- Punto 2
universoAptoParaPendex :: Universo -> Bool
universoAptoParaPendex = any ((< 45) . edad) . habitantes

personajesConVariasHabilidades :: Universo -> [Personaje]
personajesConVariasHabilidades = filter ((> 1) . length . habilidades) . habitantes

energiaTotalDelUniverso :: Universo -> Number
energiaTotalDelUniverso universo = foldr ((+) . energia) 0 (personajesConVariasHabilidades universo)


-- Punto 3
type Energia = Number

quitarHabilidad :: Habilidad -> Personaje -> Personaje
quitarHabilidad habilidadAQuitar personaje = personaje{habilidades = filter (/= habilidadAQuitar) (habilidades personaje)}

quitarEnergia :: Energia -> Personaje -> Personaje
quitarEnergia energiaAQuitar personaje = personaje{energia = energia personaje - energiaAQuitar}

atacarHabilidades :: Personaje -> Personaje
atacarHabilidades personaje
    | ((<= 2) . length . habilidades) personaje         = personaje{habilidades = []}
    | otherwise                                         = personaje

type Gema = Personaje -> Personaje

mente :: Energia -> Gema
mente = quitarEnergia

alma :: Habilidad -> Gema
alma habilidad = quitarHabilidad habilidad . quitarEnergia 10

type Planeta = String
espacio :: Planeta -> Gema
espacio nuevoPlaneta personaje = quitarEnergia 20 personaje{planeta = nuevoPlaneta}

poder :: Gema
poder personaje = (atacarHabilidades . quitarEnergia (energia personaje)) personaje

tiempo :: Gema
tiempo personaje = quitarEnergia 50 personaje {edad = max 18 $ div (edad personaje) 2}

loca :: Gema -> Gema
loca gema = gema . gema


-- Punto 4
guanteleteDeGoma :: Guantelete
guanteleteDeGoma = Guantelete {material = "goma", gemas = [tiempo, alma "usar Mjolnit", loca poder]}


-- Punto 5
utilizar :: [Gema] -> Personaje -> Personaje
utilizar gemas enemigo = foldr ($) enemigo gemas


-- Punto 6
gemaMasPoderosa :: Personaje -> Guantelete -> Gema
gemaMasPoderosa personaje = gemaMasPoderosaDe personaje . gemas 

gemaMasPoderosaDe :: Personaje -> [Gema] -> Gema
gemaMasPoderosaDe _ [gema] = gema
gemaMasPoderosaDe personaje (gema1:gema2:gemas)
    | (energia . gema1) personaje < (energia . gema2) personaje         = gemaMasPoderosaDe personaje (gema1:gemas)
    | otherwise                                                         = gemaMasPoderosaDe personaje (gema2:gemas)


-- Punto 7
infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas tiempo)
 
usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemas) guantelete

-- Test Data
hulk = Personaje "Hulk" 50 100 ["aplastar", "saltar", "correr"] "Tierra"


-- gemaMasPoderosa no se puede ejecutar por consola porque no converge a un valor debido a la lista infinita
-- usoLasTresPrimerasGemas se puede ejecutar debido a la evaluacion diferida (take acota el contexto de ejecucion)