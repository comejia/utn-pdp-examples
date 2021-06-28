module Library where
import PdePreludat

-- Modelo inicial
data Jugador = Jugador {
    nombre :: String,
    padre :: String,
    habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
    fuerzaJugador :: Number,
    precisionJugador :: Number
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = Jugador "Bart" "Homero" (Habilidad 25 60)
todd = Jugador "Todd" "Ned" (Habilidad 15 80)
rafa = Jugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = Tiro {
    velocidad :: Number,
    precision :: Number,
    altura :: Number
} deriving (Eq, Show)

type Puntos = Number

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)

mayorSegun f a b
    | f a > f b = a
    | otherwise = b


-- Punto 1
type PaloDeGolf = Habilidad -> Tiro

putter :: PaloDeGolf
putter habilidad = Tiro 10 (precisionJugador habilidad * 2) 0

madera :: PaloDeGolf
madera habilidad = Tiro 100 (precisionJugador habilidad / 2) 5

hierro :: Number -> PaloDeGolf
hierro n habilidad = Tiro (fuerzaJugador habilidad * n) (precisionJugador habilidad / n) (max 0 (n - 3))

palosDisponibles :: [PaloDeGolf]
palosDisponibles = [putter, madera] ++ map hierro [1..10]


-- Punto 2
golpe :: Jugador -> PaloDeGolf -> Tiro
golpe jugador palo = (palo . habilidad) jugador


-- Punto 3
tiroDetenido = Tiro 0 0 0

esTiroAlRas :: Tiro -> Bool
esTiroAlRas = (== 0) . altura

type Obstaculo = Tiro -> Tiro

tunelConRampita :: Obstaculo
tunelConRampita tiro
    | superaTunelConRampita tiro                            = Tiro (velocidad tiro * 2) 100 0
    | otherwise                                             = tiroDetenido

superaTunelConRampita :: Tiro -> Bool
superaTunelConRampita tiro = precision tiro > 90 && esTiroAlRas tiro

type LargoLaguna = Number
laguna :: LargoLaguna -> Obstaculo
laguna largoLaguna tiro
    | superaLaguna tiro                                     = Tiro (velocidad tiro) (precision tiro) (altura tiro / largoLaguna)
    | otherwise                                             = tiroDetenido

superaLaguna :: Tiro -> Bool
superaLaguna tiro = velocidad tiro > 80 && (between 1 5 . altura) tiro

hoyo :: Obstaculo
hoyo tiro
    | superaHoyo tiro                                       = Tiro 100 100 100 -- Se inventa para seguir con la resolucion
    | otherwise                                             = tiroDetenido

superaHoyo :: Tiro -> Bool
superaHoyo tiro = (between 5 20 . velocidad) tiro && esTiroAlRas tiro && precision tiro > 95


superaObstaculo :: Obstaculo -> Tiro -> Bool
superaObstaculo obstaculo tiro = ((/= (Tiro 0 0 0)) . obstaculo) tiro -- Se hardcodea Tiro 0 0 0


-- Punto 4
type ListaObstaculos = [Obstaculo]

palosUtiles :: Jugador -> Obstaculo -> [PaloDeGolf]
palosUtiles jugador obstaculo = filter (superaObstaculo obstaculo . golpe jugador) palosDisponibles

cantidadDeObstaculosConsecutivos :: ListaObstaculos -> Tiro -> Number
cantidadDeObstaculosConsecutivos obstaculos tiro = (length . takeWhile (flip(superaObstaculo) tiro)) obstaculos

paloMasUtil :: Jugador -> ListaObstaculos -> PaloDeGolf
paloMasUtil jugador obstaculos = maximoSegun(cantidadDeObstaculosConsecutivos obstaculos . golpe jugador) palosDisponibles

-- Test Data
listaObstaculos = [tunelConRampita, tunelConRampita, hoyo]


-- Punto 5
type TablaDePuntos = [(Jugador, Puntos)]

jugador :: (Jugador, Puntos) -> Jugador
jugador (_jugador, _) = _jugador

puntos :: (Jugador, Puntos) -> Puntos
puntos (_, _puntos) = _puntos

type ListaDePadres = [String]

padresQuePerdieron :: TablaDePuntos -> ListaDePadres
padresQuePerdieron tabla = map (padre . jugador) $ filter (/= ganador tabla) tabla

ganador :: TablaDePuntos -> (Jugador, Puntos)
ganador tabla = maximoSegun puntos tabla

-- Test Data
tablaDePuntos = [(bart, 10), (todd, 5), (rafa, 50)]