module Spec where
import PdePreludat
import Library
import Test.Hspec

-- frutas
naranja = Fruta 40 "naranja" ["vitamina C", "antioxidante"]
pelon = Fruta 25 "pelon" ["rico"]
banana = Fruta 60 "banana" ["potasio", "reconstituyente muscular", "mejora el dormir"]
 
todasLasFrutas = [naranja, pelon, banana]
 
-- dietas
unaDietaImposible = Dieta [banana, pelon] 84
unaDietaPosible = Dieta [banana, pelon] 85
unaDieta = Dieta todasLasFrutas 100

-- tests
correrTests :: IO ()
correrTests = hspec $ do
  describe "Tests de Kata 4" $ do
   describe "Dieta imposible" $ do
     it "Debe detectar una dieta imposible" $ do
       unaDietaImposible `shouldSatisfy` dietaImposible
     it "Debe permitir una dieta posible" $ do
       unaDietaPosible `shouldNotSatisfy` dietaImposible
   describe "Alguna tiene propiedad" $ do
     it "Debe detectar si alguna fruta tiene alguna propiedad" $ do
       unaDieta `shouldSatisfy` algunaTienePropiedad "antioxidante"
     it "Debe fallar si ninguna de las frutas tiene esa propiedad" $ do
       unaDieta `shouldNotSatisfy` algunaTienePropiedad "Antioxidante"
