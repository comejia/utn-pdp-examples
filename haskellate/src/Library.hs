module Library where
import PdePreludat


-- Punto 1
--type Ingrediente = String
type Gramos = Number
type Porcentaje = Number

data Chocolate = Chocolate {
    nombreFancy :: String,
    ingredientes :: [Ingrediente],
    peso :: Gramos,
    porcentajeDeCacao :: Porcentaje,
    porcentajeDeAzucar :: Porcentaje
} deriving (Show, Eq)

type Precio = Number

esChocolateAmargo :: Chocolate -> Bool
esChocolateAmargo = (> 60) . porcentajeDeCacao

esAptoDiabeticos :: Chocolate -> Bool
esAptoDiabeticos = (== 0) . porcentajeDeAzucar

precioPremium :: Chocolate -> Precio
precioPremium chocolate
    | esAptoDiabeticos chocolate                            = 8
    | otherwise                                             = 5

cantidadDeIngredientes :: Chocolate -> Number
cantidadDeIngredientes = length . ingredientes

precioDeChocolate :: Chocolate -> Precio
precioDeChocolate chocolate
    | esChocolateAmargo chocolate                           = peso chocolate * precioPremium chocolate
    | cantidadDeIngredientes chocolate > 4                  = 8 * cantidadDeIngredientes chocolate
    | otherwise                                             = 1.5 * peso chocolate


-- Punto 2
data Ingrediente = Ingrediente {
    nombre :: String,
    calorias :: Number
} deriving (Show, Eq)

esBombonAsesino :: Chocolate -> Bool
esBombonAsesino = any ((> 200) . calorias) . ingredientes

type Calorias = Number
totalCalorias :: Chocolate -> Calorias
totalCalorias = foldr ((+) . calorias) 0 . ingredientes

type CajaChocolate = [Chocolate]
aptoParaNinios :: CajaChocolate -> CajaChocolate
aptoParaNinios = take 3 . filter (not . esBombonAsesino)