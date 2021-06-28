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

maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun f = foldl1 (mayorSegun f)

mayorSegun :: Ord x => (t -> x) -> t -> t -> t
mayorSegun f a b
    | f a > f b = a
    | otherwise = b


-- Punto 1
type PaloDeGolf = Habilidad -> Tiro

putter :: PaloDeGolf
putter habilidad = Tiro 10 (precisionJugador habilidad * 2) 0

madera :: PaloDeGolf
madera habilidad = Tiro 100 (precisionJugador habilidad `div` 2) 5

hierro :: Number -> PaloDeGolf
hierro n habilidad = Tiro (fuerzaJugador habilidad * n) (precisionJugador habilidad `div` n) (max 0 (n - 3))

palosDisponibles :: [PaloDeGolf]
palosDisponibles = [putter, madera] ++ map hierro [1..10]


-- Punto 2
golpe :: Jugador -> PaloDeGolf -> Tiro
golpe jugador palo = (palo . habilidad) jugador


-- Punto 3
tiroDetenido = Tiro 0 0 0

esTiroAlRas :: Tiro -> Bool
esTiroAlRas = (== 0) . altura

--type Obstaculo = Tiro -> Tiro
data Obstaculo = Obstaculo {
    puedeSuperar :: Tiro -> Bool,
    efectoAlSuperar :: Tiro -> Tiro
} deriving (Eq, Show)

tunelConRampita :: Obstaculo
-- tunelConRampita tiro
--     | superaTunelConRampita tiro                            = Tiro (velocidad tiro * 2) 100 0
--     | otherwise                                             = tiroDetenido
tunelConRampita = Obstaculo superaTunelConRampita efectoRampita

superaTunelConRampita :: Tiro -> Bool
superaTunelConRampita tiro = precision tiro > 90 && esTiroAlRas tiro

efectoRampita :: Tiro -> Tiro
efectoRampita tiro = Tiro (velocidad tiro * 2) 100 0


type LargoLaguna = Number
laguna :: LargoLaguna -> Obstaculo
-- laguna largoLaguna tiro
--     | superaLaguna tiro                                     = Tiro (velocidad tiro) (precision tiro) (altura tiro / largoLaguna)
--     | otherwise                                             = tiroDetenido
laguna largoLaguna = Obstaculo superaLaguna (efectoLaguna largoLaguna)

superaLaguna :: Tiro -> Bool
superaLaguna tiro = velocidad tiro > 80 && (between 1 5 . altura) tiro

efectoLaguna :: LargoLaguna -> Tiro -> Tiro
efectoLaguna largoLaguna tiro = Tiro (velocidad tiro) (precision tiro) (altura tiro `div` largoLaguna)


hoyo :: Obstaculo
-- hoyo tiro
--     | superaHoyo tiro                                       = Tiro 100 100 100 -- Se inventa para seguir con la resolucion
--     | otherwise                                             = tiroDetenido
hoyo = Obstaculo superaHoyo efectoHoyo

superaHoyo :: Tiro -> Bool
superaHoyo tiro = (between 5 20 . velocidad) tiro && esTiroAlRas tiro && precision tiro > 95

efectoHoyo :: Tiro -> Tiro
efectoHoyo _ = tiroDetenido

intentarSuperarObstaculo :: Obstaculo -> Tiro -> Tiro
intentarSuperarObstaculo obstaculo tiro
    | puedeSuperar obstaculo tiro                   = efectoAlSuperar obstaculo tiro
    | otherwise                                     = tiroDetenido


-- Punto 4
--superaObstaculo :: Obstaculo -> Tiro -> Bool
--superaObstaculo obstaculo tiro = ((/= (Tiro 0 0 0)) . obstaculo) tiro -- Se hardcodea Tiro 0 0 0
--superaObstaculo = puedeSuperar

type ListaObstaculos = [Obstaculo]

palosUtiles :: Jugador -> Obstaculo -> [PaloDeGolf]
palosUtiles jugador obstaculo = filter (puedeSuperar obstaculo . golpe jugador) palosDisponibles

cantidadDeObstaculosConsecutivos :: ListaObstaculos -> Tiro -> Number
cantidadDeObstaculosConsecutivos [] tiro = 0
cantidadDeObstaculosConsecutivos (obstaculo:obstaculos) tiro
    | puedeSuperar obstaculo tiro                   = 1 + cantidadDeObstaculosConsecutivos obstaculos (efectoAlSuperar obstaculo tiro)
    | otherwise                                     = 0
--cantidadDeObstaculosConsecutivos' :: ListaObstaculos -> Tiro -> Number
--cantidadDeObstaculosConsecutivos' obstaculos tiro = (length . takeWhile (flip(puedeSuperar) tiro)) obstaculos -- No funciona!!

paloMasUtil :: Jugador -> ListaObstaculos -> PaloDeGolf
paloMasUtil jugador obstaculos = maximoSegun(cantidadDeObstaculosConsecutivos obstaculos . golpe jugador) palosDisponibles

-- Test Data
listaObstaculos = [tunelConRampita, tunelConRampita, hoyo]


-- Punto 5
jugadorDeTorneo :: (Jugador, Puntos) -> Jugador
jugadorDeTorneo = fst

puntosGanados :: (Jugador, Puntos) -> Puntos
puntosGanados = snd

type ListaDePadres = [String]
padresQuePerdieron :: [(Jugador, Puntos)] -> ListaDePadres
--padresQuePerdieron tabla = map (padre . jugadorDeTorneo) $ filter (/= ganador tabla) tabla -- Si habia empate, siempre ganaba uno!!
padresQuePerdieron tabla = map (padre . jugadorDeTorneo) $ filter (not . gano tabla) tabla

gano :: [(Jugador, Puntos)] -> (Jugador, Puntos) -> Bool
gano tabla unJugadorYSusPuntos = (all ((< puntosGanados unJugadorYSusPuntos) . puntosGanados) . filter (/= unJugadorYSusPuntos)) tabla

--ganador :: [(Jugador, Puntos)] -> (Jugador, Puntos)
--ganador tabla = maximoSegun puntosGanados tabla

-- Test Data
tablaDePuntos = [(bart, 10), (todd, 5), (rafa, 20)]