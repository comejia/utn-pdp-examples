module Spec where
import Control.Exception
import PdePreludat
import Library
import Test.Hspec
import TestData

correrTests :: IO ()
correrTests = hspec $ do
  -- Tests Punto 1
  describe "Test de Coeficiente de satisfacción" $ do
    it "Dada una persona muy feliz de 25 años de edad, entonces su coeficiente de satisfacción es 2525" $ do
      coeficienteDeSatisfaccion personaMuyFeliz{edad=25} `shouldBe` 2525
    it "Dada una persona moderadamente feliz con 2 sueños, entonces su coeficiente de satisfacción es 200" $ do
      coeficienteDeSatisfaccion personaModeradamenteFeliz{suenios=[queTodoSigaIgual, recibirseDeUnaCarrera "Sistemas"]} `shouldBe` 200
    it "Dada una persona poco feliz, entonces su coeficiente de satisfacción es 25" $ do
      coeficienteDeSatisfaccion personaPocoFeliz `shouldBe` 25
  describe "Test de Grado de ambición" $ do
    it "Dada una persona muy feliz con 2 sueños, entonces su grado de ambición es 202" $ do
      gradoDeAmbicion personaMuyFeliz{suenios=[queTodoSigaIgual, recibirseDeUnaCarrera "Sistemas"]} `shouldBe` 202
    it "Dada una persona moderadamente feliz de 26 años y con 2 sueños, entonces su grado de ambición es 52" $ do
      gradoDeAmbicion personaModeradamenteFeliz{edad=26, suenios=[queTodoSigaIgual, recibirseDeUnaCarrera "Sistemas"]} `shouldBe` 52
    it "Dada una persona poco feliz con 1 sueño, entonces su grado de ambición es 2" $ do
      gradoDeAmbicion personaPocoFeliz{suenios=[queTodoSigaIgual]} `shouldBe` 2

  -- Tests Punto 2
  describe "Test de Nombre largo" $ do
    it "Dada una persona cuyo nombre es menor o igual al limite de letras, entonces no tiene un nombre largo" $ do
      personaConNombreNormal `shouldNotSatisfy` nombreLargo
    it "Dada una persona cuyo nombre es mayor al limite de letras, entonces tiene un nombre largo" $ do
      personaConNombreLargo `shouldSatisfy` nombreLargo
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

  -- Tests Punto 3
  describe "Test de Sueños cumplidos" $ do
    describe "Recibirse de una carrera" $ do
      it "Dada una persona que se recibe de una carrera, entonces adquiere una habilidad" $ do
        (length . habilidades . recibirseDeUnaCarrera "Ingenieria") unaPersona `shouldBe` 2
      it "Dada una persona que se recibe de una carrera, entonces aumenta sus felicidonios" $ do
        (felicidonios . recibirseDeUnaCarrera "Ingenieria") unaPersona `shouldBe` 10101
    describe "Viajar a una lista de ciudades" $ do
      it "Dada una persona que viaja a una lista de ciudades, entonces aumenta su edad un año" $ do
        (edad . viajarAListaDeCiudades ["Londres", "Paris"]) unaPersona `shouldBe` 27
      it "Dada una persona que viaja a una lista de ciudades, entonces aumenta sus felicidonios" $ do
        (felicidonios . viajarAListaDeCiudades ["Londres", "Paris"]) unaPersona `shouldBe` 301
    describe "Enamorarse de otra persona" $ do
      it "Dada una persona que se enamora de otra, entonces aumenta sus felicidonios" $ do
        (felicidonios . enamorarseDeOtraPersona otraPersona) unaPersona `shouldBe` 152
    describe "Combo perfecto" $ do
      it "Dada una persona que realiza un combo perfecto, entonces aumentan sus felicidonios" $ do
        (felicidonios . comboPerfecto) unaPersona `shouldBe` 8401


  -- Tests Punto 4
  describe "Tests Fuente de los deseos" $ do
    describe "Fuente minimalista" $ do
      it "Dada una fuente minimalista, entonces la persona cumple su primer sueño" $ do
        (felicidonios . fuenteMinimalisa) personaConVariosSuenios `shouldBe` 8100
      it "Dada una fuente minimalista, entonces la persona tiene menos sueños que cumplir" $ do
        (length . suenios . fuenteMinimalisa) personaConVariosSuenios `shouldBe` 2
    describe "Fuente copada" $ do
      it "Dada una fuente copada, entonces la persona cumple todos sus sueños" $ do
        (felicidonios . fuenteCopada) personaConVariosSuenios `shouldBe` 16400
      it "Dada una fuente copada, entonces la persona no tiene sueños que cumplir" $ do
        (length . suenios . fuenteCopada) personaConVariosSuenios `shouldBe` 0
    describe "Fuente a pedido" $ do
      it "Dada una fuente a pedido, entonces la persona cumple el enesimo sueño" $ do
        (felicidonios . fuenteAPedido 1) personaConVariosSuenios `shouldBe` 8100
      it "Dada una fuente a pedido, entonces la persona mantiene los mismos sueños" $ do
        (length . suenios . fuenteAPedido 3) personaConVariosSuenios `shouldBe` 3
    describe "Fuente sorda" $ do
      it "Dada una fuente sorda, entonces la persona no cumple ningun sueño" $ do
        (felicidonios . fuenteSorda) personaConVariosSuenios `shouldBe` 100

  -- Tests Punto 6
  describe "Tests Requerimientos" $ do
    describe "Sueños valiosos" $ do
      it "Dada una persona con sueños valiosos, entonces tiene sueños valiosos" $ do
        (length . sueniosValiosos) personaConSueniosValiosos `shouldBe` 2
      it "Dada una persona sin sueños valiosos, entonces no tiene sueños valiosos" $ do
        (length . sueniosValiosos) personaSinSueniosValiosos `shouldBe` 0
    describe "Alguna sueño raro" $ do
     it "Debe detectar si una persona tiene algun sueño raro" $ do
       personaConSueniosRaros `shouldSatisfy` algunSuenioRaro
     it "Debe fallar si una persona no tiene ningun sueño raro" $ do
       personaSinSueniosRaros `shouldNotSatisfy` algunSuenioRaro
    describe "Felicidad del grupo" $ do
     it "Dada una lista de personas, entonces se obtiene la felicidad total" $ do
       felicidadDelGrupo listaDePersonas `shouldBe` 10352
     it "Deba una lista vacia de personas, entonces la felicidad es 0" $ do
       felicidadDelGrupo [] `shouldBe` 0
