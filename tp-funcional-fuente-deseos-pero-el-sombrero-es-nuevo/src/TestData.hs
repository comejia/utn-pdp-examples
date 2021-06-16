module TestData where
import PdePreludat
import Library

-- Personas de prueba

-- Punto 1
personaMuyFeliz = Persona 20 [] "Pepe" 101 []
personaModeradamenteFeliz = Persona 20 [] "Pepe" 100 []
personaPocoFeliz = Persona 20 [] "Pepe" 50 []

-- Punto 2
personaConNombreNormal = Persona 20 [] "Evangelina" 101 []
personaConNombreLargo = Persona 20 [] "Maximiliano" 101 []

personaSinSuerte = Persona 20 [] "Evangelina" 14 []
personaConSuerte = Persona 20 [] "Evangelina" 12 []

personaConNombreLindo = Persona 20 [] "Melina" 14 []
personaConNombreFeo = Persona 20 [] "Ariel" 12 []

-- Punto 3
unaPersona = Persona 26 [queTodoSigaIgual] "Pepe" 101 ["Tejer"]
otraPersona = Persona 22 [queTodoSigaIgual] "Carla" 51 ["Soldar"]

-- Punto 4
personaSinSuenios = Persona 20 [] "Pepe" 100 []
personaConVariosSuenios = Persona 20 [recibirseDeUnaCarrera "Medicina", queTodoSigaIgual, comboPerfecto] "Pepe" 100 []

-- Punto 5
listaDeFuentes = [fuenteMinimalisa, fuenteCopada, fuenteSorda]

-- Punto 6
personaConSueniosValiosos = Persona 20 [recibirseDeUnaCarrera "Medicina", comboPerfecto] "Pepe" 0 []
personaSinSueniosValiosos = Persona 20 [queTodoSigaIgual] "Pepe" 0 []

personaConSueniosRaros = Persona 20 [recibirseDeUnaCarrera "Medicina", queTodoSigaIgual, comboPerfecto] "Pepe" 100 []
personaSinSueniosRaros = Persona 20 [recibirseDeUnaCarrera "Medicina", comboPerfecto] "Pepe" 100 []

listaDePersonas = [
    Persona 26 [recibirseDeUnaCarrera "Ingenieria"] "Cesar" 101 ["Programacion"], 
    Persona 27 [viajarAListaDeCiudades ["Madrid", "Paris"]] "Diego" 51 ["Mochilero"]
 ]

-- Punto 7
personaConSueniosInfinitos = Persona 20 (repeat queTodoSigaIgual) "Infinito" 100 []