module Library where
import PdePreludat


-- Punto 1
data Cliente = Cliente {
    nombreCliente :: String,
    direccion :: String
} deriving (Show, Eq)

data Chofer = Chofer {
    nombreChofer :: String,
    kmAuto :: Number,
    viajesQueTomo :: [Viaje],
    condicion :: Condicion
} deriving (Show, Eq)

type Dia = Number
type Mes = Number
type Anio = Number
data Viaje = Viaje {
    fecha :: (Dia, Mes, Anio),
    cliente :: Cliente,
    costo :: Number
} deriving (Show, Eq)

-- Punto 2
type Condicion = Viaje -> Bool

cualquerViaje :: Condicion
cualquerViaje _ = True

viajeMayorA200 :: Condicion
viajeMayorA200 = (> 200) . costo

type Letras = Number
nombreClienteMayorQue :: Letras -> Condicion
nombreClienteMayorQue n = (>n) . length . nombreCliente . cliente

type Domicilio = String
clienteNoVivaEn :: Domicilio -> Condicion
clienteNoVivaEn domicilio = (/= domicilio) . direccion . cliente


-- Punto 3a
lucas :: Cliente
lucas = Cliente "Lucas" "Victoria"
-- Punto 3b
daniel :: Chofer
daniel = Chofer "Daniel" 23500 [Viaje{cliente = lucas, fecha = (20,04,2017), costo = 150}] (clienteNoVivaEn "Olivos")
-- Punto 3c
alejandra :: Chofer
alejandra = Chofer "Alejandra" 180000 [] cualquerViaje


-- Punto 4
puedeTomarViaje :: Chofer -> Viaje -> Bool
puedeTomarViaje chofer viaje = (condicion chofer) viaje


-- Punto 5
type Liquidacion = Number
liquidacionDeChofer :: Chofer -> Liquidacion
liquidacionDeChofer = foldr ((+) . costo) 0 . viajesQueTomo


-- Punto 6
cantidadDeViajes :: Chofer -> Number
cantidadDeViajes = length . viajesQueTomo

menosViajesQue :: Chofer -> Chofer -> Chofer
menosViajesQue chofer1 chofer2
    | cantidadDeViajes chofer1 <= cantidadDeViajes chofer1      = chofer1
    | otherwise                                                 = chofer2

incorporarViaje :: Viaje -> Chofer -> Chofer
incorporarViaje viaje chofer = chofer {viajesQueTomo = viajesQueTomo chofer ++ [viaje]}

-- Punto 6a
choferesQueTomanViaje :: Viaje -> [Chofer] -> [Chofer]
choferesQueTomanViaje viaje choferes = filter (flip(puedeTomarViaje) viaje) choferes
-- Punto 6b
choferConMenosViajes :: Viaje -> [Chofer] -> Chofer
choferConMenosViajes viaje = foldl1 (menosViajesQue)
-- Punto 6c
realizarViaje :: Viaje -> [Chofer] -> Chofer
realizarViaje viaje = incorporarViaje viaje . choferConMenosViajes viaje . choferesQueTomanViaje viaje


-- Punto 7
