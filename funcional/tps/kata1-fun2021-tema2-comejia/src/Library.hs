module Library where
import PdePreludat

esPar :: Number -> Bool
esPar numero = numero `mod` 2 == 0

calculin2 :: Number -> Number -> Number
calculin2 numero1 numero2 
    | numero1 < numero2         = 2 * numero1
    | esPar numero1 == True     = numero1 * numero2
    | otherwise                 = numero1 + (numero2 `div` 2)
