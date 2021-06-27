module Library where
import PdePreludat


-- Punto 1
type Gramos = Number
type Porcentaje = Number

data Ingrediente = Ingrediente {
    nombre :: String,
    calorias :: Number
} deriving (Show, Eq)

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
esBombonAsesino :: Chocolate -> Bool
esBombonAsesino = any ((> 200) . calorias) . ingredientes

type Calorias = Number
totalCalorias :: Chocolate -> Calorias
totalCalorias = foldr ((+) . calorias) 0 . ingredientes

type CajaChocolate = [Chocolate]
aptoParaNinios :: CajaChocolate -> CajaChocolate
aptoParaNinios = take 3 . filter (not . esBombonAsesino)


-- Punto 3
agregarIngrediente :: Ingrediente -> Chocolate -> Chocolate
agregarIngrediente ingrediente chocolate = chocolate {
    ingredientes = ingredientes chocolate ++ [ingrediente]
}

agregarNivelDeAzucar :: PorcentajeDeAzucar -> Chocolate -> Chocolate
agregarNivelDeAzucar porcentajeDeAzucarAAgregar chocolate = chocolate {
    porcentajeDeAzucar = porcentajeDeAzucar chocolate + porcentajeDeAzucarAAgregar
}

type Proceso = Chocolate -> Chocolate

type Unidades = Number
type Fruta = String
frutalizado :: Fruta -> Unidades -> Proceso
--frutalizado _ 0 chocolate = chocolate
--frutalizado fruta unidades chocolate = (frutalizado fruta (unidades - 1) . agregarIngrediente (Ingrediente fruta 2)) chocolate
frutalizado fruta unidades = agregarIngrediente (Ingrediente fruta (unidades * 2))

dulceDeLeche :: Proceso
dulceDeLeche chocolate = agregarIngrediente (Ingrediente "Dulce de leche" 220) chocolate {
    nombreFancy = nombreFancy chocolate ++ " " ++ "tentacion"
}

type PorcentajeDeAzucar = Number
celiaCrucera :: PorcentajeDeAzucar -> Proceso
celiaCrucera = agregarNivelDeAzucar

type GradoDeAlcohol = Number
embriagadora :: GradoDeAlcohol -> Proceso
embriagadora gradosDeAlcohol chocolate -- = (agregarIngrediente (Ingrediente "Licor" (min 30 gradosDeAlcohol)) . agregarNivelDeAzucar 20) chocolate
    | gradosDeAlcohol >= 30                                 = (agregarIngrediente (Ingrediente "Licor" 30) . agregarNivelDeAzucar 20) chocolate
    | otherwise                                             = (agregarIngrediente (Ingrediente "Licor" gradosDeAlcohol) . agregarNivelDeAzucar 20) chocolate


-- Punto 4
type Receta = [Proceso]
receta :: Receta
receta = [frutalizado "Naranja" 10, dulceDeLeche, embriagadora 32]


-- Punto 5
prepararChocolate :: Chocolate -> Receta -> Chocolate
prepararChocolate chocolate procesos = foldr ($) chocolate procesos


-- Punto 6
type CriterioDeAceptacion = Ingrediente -> Bool

data Persona = Persona {
    nivelDeSaturacion :: Calorias,
    criterio :: CriterioDeAceptacion
}

noCumpleCriterio :: Chocolate -> Persona -> Bool
noCumpleCriterio chocolate persona = any (not . criterio persona) (ingredientes chocolate)


comerChocolate :: Persona -> Chocolate -> Persona
comerChocolate persona chocolate= persona {
    nivelDeSaturacion = nivelDeSaturacion persona - totalCalorias chocolate
}

hastaAcaLlegue :: Persona -> CajaChocolate -> CajaChocolate
hastaAcaLlegue _ [] = []
hastaAcaLlegue persona (primerChocolate:restoDeChocolates)
    | noCumpleCriterio primerChocolate persona                      = hastaAcaLlegue persona restoDeChocolates
    | ((<= 0) . nivelDeSaturacion) persona                          = []
    | otherwise                                                     = primerChocolate:hastaAcaLlegue (comerChocolate persona primerChocolate) restoDeChocolates


-- Punto 7
totalCalorias' :: CajaChocolate -> Calorias
totalCalorias' = foldr ((+) . totalCalorias) 0

chocoArroz :: Chocolate
chocoArroz = Chocolate "chocoArroz" [Ingrediente "arroz" 1, Ingrediente "potasio" 10] 1 300 10

cajaInfinita = chocoArroz:cajaInfinita
