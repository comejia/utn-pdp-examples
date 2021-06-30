module Library where
import PdePreludat


data Cliente = Cliente {
    nombreCliente :: String,
    direccion :: String
}

type Condicion = Number
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

