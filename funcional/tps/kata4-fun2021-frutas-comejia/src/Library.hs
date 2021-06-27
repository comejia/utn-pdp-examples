module Library where
import PdePreludat

data Fruta = Fruta {
 calorias :: Number,
 nombre :: String,
 propiedades :: [String]
} deriving (Eq, Show)
 
data Dieta = Dieta {
 frutas :: [Fruta],
 maximoCalorias :: Number
} deriving (Eq, Show)

-- punto 1
dietaImposible :: Dieta -> Bool
dietaImposible dieta = sumatoriaCalorias dieta > maximoCalorias dieta
 
sumatoriaCalorias :: Dieta -> Number
sumatoriaCalorias dieta = (foldl1 (+) . map calorias . frutas) dieta
 
-- punto 2
algunaTienePropiedad :: String -> Dieta -> Bool
algunaTienePropiedad propiedad dieta = (any (elem propiedad) . map propiedades . frutas) dieta
