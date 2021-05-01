module Library where
import PdePreludat

type Modelo = String
type Kilometros = Number
 
type Auto = (Modelo, Kilometros)
 
modelo :: Auto -> Modelo
modelo = fst
 
kilometraje :: Auto -> Kilometros
kilometraje = snd

-- Punto 1
autoVeloz :: Auto -> Bool
autoVeloz = odd . length . modelo

-- Punto 2
cambioDeAceite :: Auto -> Bool
cambioDeAceite = (> 10000) . kilometraje
