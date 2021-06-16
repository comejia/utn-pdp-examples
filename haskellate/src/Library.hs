module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero


-- Punto 1

type Ingrediente = String
type Gramos = Number
type Porcentaje = Number

data Chocolate = Chocolate {
    nombre :: String,
    ingredientes :: [Ingrediente],
    peso :: Gramos,
    porcentajeDeCacao :: Porcentaje,
    porcentajeDeAzucar :: Porcentaje
}

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

