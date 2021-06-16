# Kata 4 - Frutas

## Enunciado

Dada la siguiente definición de frutas y de una dieta nutricional recetada para una persona:

```hs
data Fruta = Fruta {
 calorias :: Number,
 nombre :: String,
 propiedades :: [String]
} deriving (Eq, Show)
 
data Dieta = Dieta {
 frutas :: [Fruta],
 maximoCalorias :: Number
} deriving (Eq, Show)
```

Se pide implementar y verificar que los tests unitarios provistos pasen para los siguientes puntos:

## Punto 1

Saber si una dieta es imposible de cumplir, esto es si la sumatoria de calorías de las frutas supera el máximo de calorías de la dieta. Por ejemplo, si una dieta contiene manzana (10 calorías) y pera (12 calorías), una dieta de 22 calorías o más es posible de cumplir, una dieta de menos de 22 es imposible de cumplir.

## Punto 2 

Dada una dieta, queremos saber si alguna tiene una propiedad, por ejemplo, "antioxidante". Si una dieta contiene pelón ("vitamina C") y cereza ("acidez"), la función debería satisfacerse si buscamos "vitamina C" o "acidez", respetando las mayúsculas y minúsculas.

## **IMPORTANTE**

- Solo puede resolverse con funciones de orden superior, no puede utilizar recursividad en ningún punto. 
- Debe utilizar composición únicamente mediante la función `(.)`.
- Recomendamos revisar los nombres de variables (ninguna de una sola letra, deben expresar claramente el dominio que están resoviendo)
