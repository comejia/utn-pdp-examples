module Library where
import PdePreludat


-- Punto 1
data Cliente = Cliente {
    nombreCliente :: String,
    direccion :: String
}

data Chofer = Chofer {
    nombreChofer :: String,
    kmAuto :: Number,
    viajesQueTomo :: [Viaje],
    condicion :: Condicion
}

type Dia = Number
type Mes = Number
data Viaje = Viaje {
    fecha :: (Dia, Mes),
    cliente :: Cliente,
    costo :: Number
}

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


