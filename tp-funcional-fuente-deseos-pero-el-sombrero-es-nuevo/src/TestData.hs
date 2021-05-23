module TestData where
import PdePreludat
import Library

-- Personas de prueba

personMuyFeliz = Persona 20 [] "Pepe" 101 []
personaModeradamenteFeliz = Persona 20 [] "Pepe" 100 []
personaPocoFeliz = Persona 20 [] "Pepe" 50 []

personConNombreNormal = Persona 20 [] "Evangelina" 101 []
personConNombreLargo = Persona 20 [] "Maximiliano" 101 []

personaSinSuerte = Persona 20 [] "Evangelina" 14 []
personaConSuerte = Persona 20 [] "Evangelina" 12 []

personaConNombreLindo = Persona 20 [] "Melina" 14 []
personaConNombreFeo = Persona 20 [] "Ariel" 12 []

pepe = Persona {
    edad = 26,
    suenios = [queTodoSigaIgual],
    nombre = "Pepe",
    felicidonios = 101,
    habilidades = ["Tejer"]
}

carla = Persona {
    edad = 22,
    suenios = [queTodoSigaIgual],
    nombre = "Carla",
    felicidonios = 51,
    habilidades = ["Soldar"]
}