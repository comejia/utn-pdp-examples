module Library where
import PdePreludat


-- Punto 1
type Idioma = String

data Turista = Turista {
    nivelDeCansancio :: Number,
    nivelDeStress :: Number,
    viajaSolo :: Bool,
    idiomas :: [Idioma]
} deriving(Show)

-- Test data
ana = Turista 0 21 False ["Español"]
beto = Turista 15 15 True ["Aleman"]
cathi = Turista 15 15 True ["Aleman", "Catalan"]


-- Punto 2
type Excursion = Turista -> Turista

irALaPlaya :: Excursion
irALaPlaya turista
    | viajaSolo turista         = turista{ nivelDeCansancio = nivelDeCansancio turista - 5 }
    | otherwise                 = turista{ nivelDeStress = nivelDeStress turista - 1 }

type Elemento = String
apreciarElementoDePaisaje :: Elemento -> Excursion
apreciarElementoDePaisaje elemento turista = turista{ nivelDeStress = nivelDeStress turista - length elemento }

salirAHablarUnIdioma :: Idioma -> Excursion
salirAHablarUnIdioma idioma turista = turista{ idiomas = idiomas turista ++ [idioma], viajaSolo = False }

type Minutos = Number
caminar :: Minutos -> Excursion
caminar min turista = turista{nivelDeCansancio = nivelDeCansancio turista + nivelDeIntensidad min, nivelDeStress = nivelDeStress turista - nivelDeIntensidad min }

nivelDeIntensidad :: Minutos -> Number
nivelDeIntensidad min = div min 4

data Marea = Tranquila | Moderada | Fuerte deriving (Show, Eq, Ord)

paseoEnBarco :: Marea -> Excursion
paseoEnBarco Tranquila turista = (salirAHablarUnIdioma "Aleman" . apreciarElementoDePaisaje "mar" . caminar 10) turista
paseoEnBarco Moderada turista = turista
paseoEnBarco Fuerte turista = turista{ nivelDeStress = nivelDeStress turista + 6, nivelDeCansancio = nivelDeCansancio turista + 10 }

-- Punto 2a
realizarExcursion :: Excursion -> Turista -> Turista
realizarExcursion excursion turista = excursion turista{ nivelDeStress = nivelDeStress turista * 0.9 }

-- Punto 2b
deltaSegun :: (a -> Number) -> a -> a -> Number
deltaSegun f algo1 algo2 = f algo1 - f algo2

type Indice = Turista -> Number
type VariacionIndice = Number
deltaExcursionSegun :: Indice -> Turista -> Excursion -> VariacionIndice
deltaExcursionSegun indice turista excursion = deltaSegun indice (realizarExcursion excursion turista) turista

-- Punto 2c
excursionEducativa :: Excursion -> Turista -> Bool
excursionEducativa excursion turista = ((> 0) . deltaExcursionSegun (length . idiomas) turista) excursion

excursionDesestresante :: Excursion -> Turista -> Bool
excursionDesestresante excursion turista = ((<= -3) . deltaExcursionSegun nivelDeStress turista) excursion


-- Punto 3
type Tour = [Excursion]

completo :: Tour
completo = [caminar 20, apreciarElementoDePaisaje "cascada", caminar 40, irALaPlaya, salirAHablarUnIdioma "melmacquiano"]

ladoB :: Excursion -> Tour
ladoB excursion = [paseoEnBarco Tranquila, excursion, caminar (2*60)]

islaVecina :: Marea -> Tour
islaVecina marea
    | marea /= Fuerte           = [paseoEnBarco marea, irALaPlaya, paseoEnBarco marea]
    | otherwise                 = [paseoEnBarco Fuerte, apreciarElementoDePaisaje "lago", paseoEnBarco Fuerte]

-- Punto 3a
hacerTour :: Turista -> Tour -> Turista
hacerTour turista tour = foldl (flip(realizarExcursion)) turista{ nivelDeStress = nivelDeStress turista + length tour } tour

-- Punto 3b
consiguePareja :: Turista -> Excursion -> Bool
consiguePareja turista excursion = (not . viajaSolo . flip(realizarExcursion) turista) excursion

esTourConvincente :: Turista -> Tour -> Bool
esTourConvincente turista tour = any (\excursion -> excursionDesestresante excursion turista && consiguePareja turista excursion) tour

existeTourConvincente :: [Tour] -> Turista -> Bool
existeTourConvincente tours turista = any (esTourConvincente turista) tours

-- Test Data
conjuntoDeTours = [completo, ladoB (apreciarElementoDePaisaje "hojas")]


-- Punto 3c
type Esperitualidad = Number

espiritualidad :: Turista -> Esperitualidad
espiritualidad turista = nivelDeStress turista + nivelDeCansancio turista

espiritualidadQueRecibeTurista :: Turista -> Tour -> Esperitualidad
espiritualidadQueRecibeTurista turista tour
    | esTourConvincente turista tour                = (espiritualidad . hacerTour turista) tour
    | otherwise                                     = 0

type Efectividad = Number
efectividadDeTour :: [Turista] -> Tour -> Efectividad
efectividadDeTour turistas tour = foldr ((+) . (flip(espiritualidadQueRecibeTurista) tour)) 0 turistas

-- Test Data
turistas = [ana, beto]


-- Punto 4a
tourInfinito :: Tour
tourInfinito = repeat irALaPlaya

-- Punto 4b
-- Si bien irALaPlaya no modifica el estado, como Ana no viaja sola entontces solo para ella es convincente. No para beto

-- Punto 4c
-- NO