# Kata 2 - Aplicación para ciclistas

[![Build](https://github.com/pdep-mn-utn/kata-2-logico-bicilogic-comejia/actions/workflows/workflow.yml/badge.svg)](https://github.com/pdep-mn-utn/kata-2-logico-bicilogic-comejia/actions/workflows/workflow.yml)

Alumno: Cesar Mejia (comejia)

----
## Descripción del dominio
Vamos a preparar los equipos de bicicleteada del grupo lógico para competir en un torneo. Dados los siguientes datos 

```prolog
%tiene(Persona, Bicicleta).
% Bicicletas:
%   mountainBike(Marca,CantidadDeCambios)
%   playera(Marca)
%   carrera(Marca,Peso)
tiene(santi, mountainBike(zenith,21)).
tiene(fede, mountainBike(peugeot,6)).
tiene(cecilia, playera(zenith)).
tiene(juan, carrera(venzo,15)).
tiene(cecilia, carrera(gt,12)).
```

## Requerimientos
- Determinar el predicado **esGrosa/1**. Una bicicleta satisface el predicado si es mountainBike y tiene muchos cambios, es decir 18 o más o bien si es de carrera marca GT o si es una bici liviana de carrera (que pesa menos de 15 kilos).
- Determinar quién es **corredorProfesional/1**. Dada una persona, esto ocurre cuando todas las bicis que tiene la persona son grosas. El predicado debe ser inversible.
- Determinar quién es **corredorAmateur/1**. Esto ocurre cuando ninguna bicicleta que tiene es grosa. El predicado debe ser inversible.

> Deben agregar el usuario en el README.md además del badge de Github Actions.