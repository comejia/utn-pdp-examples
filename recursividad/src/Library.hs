module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero


factorial :: Number -> Number
factorial n
    | n == 0        = 1
    | n > 0         = n * factorial (n - 1)

-- Pattern matching. De esta forma rompe con num negativos
factorial' 0 = 1 -- caso base
factorial' n = n * factorial' (n - 1)

-- lenght
largoDeLista :: [a] -> Number
largoDeLista [] = 0 -- caso base
largoDeLista (_:xs) = 1 + largoDeLista xs

-- last
ultimoDeLista :: [a] -> a
ultimoDeLista [x] = x
ultimoDeLista (_:xs) = ultimoDeLista xs

-- take
tomarNElementos :: Number -> [a] -> [a]
tomarNElementos numero _ 
    | numero <= 0 = []
tomarNElementos _ [] = []
tomarNElementos numero (x:xs) = x:tomarNElementos (numero - 1) xs

--elem
elementoEnLista :: Eq a => a -> [a] -> Bool
elementoEnLista _ [] = False
elementoEnLista unElemento (x:xs) = x == unElemento || elementoEnLista unElemento xs

-- reverse
reversa :: [a] -> [a]
reversa [] = []
reversa (x:xs) = reversa xs ++ [x]

convertirABinario :: Number -> [Number]
convertirABinario numero
    | numero < 2    = [numero]
    | otherwise     = convertirABinario (div numero 2) ++ [mod numero 2]

convertirABase :: Number -> Number -> [Number]
convertirABase numero base
    | numero < base    = [numero]
    | otherwise     = convertirABase (div numero base) base ++ [mod numero base]
