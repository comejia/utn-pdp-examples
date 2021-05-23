module Spec where
import PdePreludat
import Library
import Test.Hspec
import TestData

correrTests :: IO ()
correrTests = hspec $ do
  describe "Test de Coeficiente de satisfacción" $ do
    it "Dada una persona muy feliz de 25 años de edad, entonces su coeficiente de satisfacción es 2525" $ do
      coeficienteDeSatisfaccion personMuyFeliz{edad=25} `shouldBe` 2525
    it "Dada una persona moderadamente feliz con 2 sueños, entonces su coeficiente de satisfacción es 200" $ do
      coeficienteDeSatisfaccion personaModeradamenteFeliz{suenios=[queTodoSigaIgual, recibirseDeUnaCarrera "Sistemas"]} `shouldBe` 200
    it "Dada una persona poco feliz, entonces su coeficiente de satisfacción es 25" $ do
      coeficienteDeSatisfaccion personaPocoFeliz `shouldBe` 25

  describe "Test de Grado de ambición" $ do
    it "Dada una persona muy feliz con 2 sueños, entonces su grado de ambición es 202" $ do
      gradoDeAmbicion personMuyFeliz{suenios=[queTodoSigaIgual, recibirseDeUnaCarrera "Sistemas"]} `shouldBe` 202
    it "Dada una persona moderadamente feliz de 26 años y con 2 sueños, entonces su grado de ambición es 52" $ do
      gradoDeAmbicion personaModeradamenteFeliz{edad=26, suenios=[queTodoSigaIgual, recibirseDeUnaCarrera "Sistemas"]} `shouldBe` 52
    it "Dada una persona poco feliz con 1 sueño, entonces su grado de ambición es 2" $ do
      gradoDeAmbicion personaPocoFeliz{suenios=[queTodoSigaIgual]} `shouldBe` 2



  describe "Test de Nombre largo" $ do
    it "Dada una persona cuyo nombre es menor o igual al limite de letras, entonces no tiene un nombre largo" $ do
      personConNombreNormal `shouldNotSatisfy` nombreLargo
    it "Dada una persona cuyo nombre es mayor al limite de letras, entonces tiene un nombre largo" $ do
      personConNombreLargo `shouldSatisfy` nombreLargo

  describe "Test de Persona suertuda" $ do
    it "Dada una persona cuyo coef de satisfaccion multiplicado por 3 no es par, entonces no es suertuda" $ do
      personaSinSuerte `shouldNotSatisfy` personaSuertuda
    it "Dada una persona cuyo coef de satisfaccion multiplicado por 3 es par, entonces es suertuda" $ do
      personaConSuerte `shouldSatisfy` personaSuertuda

  describe "Test de Nombre lindo" $ do
    it "Dada una persona cuyo nombre no termina en 'a', entonces no tiene un nombre lindo" $ do
      personaConNombreFeo `shouldNotSatisfy` nombreLindo
    it "Dada una persona cuyo nombre termina en 'a', entonces tiene un nombre lindo" $ do
     personaConNombreLindo `shouldSatisfy` nombreLindo



  describe "Test de Sueños cumplidos" $ do
    it "Dada una persona que se recibe de una carrera, entonces adquiere una habilidad" $ do
      (length . habilidades . recibirseDeUnaCarrera "Ingenieria") pepe `shouldBe` 2
    it "Dada una persona que se recibe de una carrera, entonces aumenta sus felicidonios" $ do
      (felicidonios . recibirseDeUnaCarrera "Ingenieria") pepe `shouldBe` 10101

    it "Dada una persona que viaja a una lista de ciudades, entonces aumenta su edad un año" $ do
      (edad . viajarAListaDeCiudades ["Londres", "Paris"]) pepe `shouldBe` 27
    it "Dada una persona que viaja a una lista de ciudades, entonces aumenta sus felicidonios" $ do
      (felicidonios . viajarAListaDeCiudades ["Londres", "Paris"]) pepe `shouldBe` 301

    it "Dada una persona que se enamora de otra, entonces aumenta sus felicidonios" $ do
      (felicidonios . enamorarseDeOtraPersona carla) pepe `shouldBe` 152

    it "Dada una persona que realiza un combo perfecto, entonces aumentan sus felicidonios" $ do
      (felicidonios . comboPerfecto) pepe `shouldBe` 8401