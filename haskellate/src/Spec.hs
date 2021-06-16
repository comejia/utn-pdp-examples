module Spec where
import PdePreludat
import Library
import Test.Hspec

-- Test Data

-- Ingredientes
cacao = Ingrediente "cacao" 10
naranja = Ingrediente "naranja" 20
limon = Ingrediente "limon" 30
pera = Ingrediente "pera" 40
uva = Ingrediente "uva" 50
mani = Ingrediente "mani" 300

-- Chocolates
chocolateAmargo = Chocolate "Muy amargo" [] 10 70 20
chocolateAmargoYAptoDiabetico = Chocolate "Muy amargo" [] 10 70 0
chocolateConMuchosIngredientes = Chocolate "El mejor" [cacao, naranja, limon, pera, uva] 10 30 20
chocolateConPocosIngredientes = Chocolate "Simple" [cacao, naranja] 10 30 20

chocolateAsesino = Chocolate "Killer" [cacao, mani, uva] 10 30 20
chocolateNoAsesino = Chocolate "Aburrido" [uva, pera, limon] 10 30 20
chocolateComun = Chocolate "Aburrido" [cacao, naranja] 10 30 20

cajaDeChocolates = [chocolateComun, chocolateAsesino, chocolateAmargo, chocolateAsesino, chocolateAmargoYAptoDiabetico, chocolateComun, chocolateConPocosIngredientes]

chocolateVacio = Chocolate "Me estas jodiendo" [] 0 0 0


correrTests :: IO ()
correrTests = hspec $ do
-- Tests Punto 1
  describe "Test Precio de chocolate" $ do
    it "Dado un chocolate amargo, entonces su precio es $50" $ do
      precioDeChocolate chocolateAmargo `shouldBe` 50
    it "Dado un chocolate amargo y apto para diabeticos, entonces su precio es $80" $ do
      precioDeChocolate chocolateAmargoYAptoDiabetico `shouldBe` 80
    it "Dado un chocolate cuya cantidad de ingredientes es mayor al limite, entonces su precio es $40" $ do
      precioDeChocolate chocolateConMuchosIngredientes `shouldBe` 40
    it "Dado un chocolate cuya cantidad de ingredientes es menor al limite, entonces su precio es $15" $ do
      precioDeChocolate chocolateConPocosIngredientes `shouldBe` 15

-- Tests Punto 2
  describe "Test Bombon asesino" $ do
    it "Dado un chocolate con algun ingrediente cuya caloria es mayor al limite, entonces es un bombon asesino" $ do
      chocolateAsesino `shouldSatisfy` esBombonAsesino
    it "Dado un chocolate con ingredientes cuyas calorias no superan el limite, entonces no es un bombon asesino" $ do
      chocolateNoAsesino `shouldNotSatisfy` esBombonAsesino

  describe "Test Total calorias" $ do
    it "Dado un chocolate comun, entonces el total de calorias es 30" $ do
      totalCalorias chocolateComun `shouldBe` 30

  describe "Test Apto para niños" $ do
    it "Dado una caja de chocolates comun, entonces la caja apta debe ser [chocolateComun, chocolateAmargo, chocolateAmargoYAptoDiabetico]" $ do
      aptoParaNinios cajaDeChocolates `shouldBe` [chocolateComun, chocolateAmargo, chocolateAmargoYAptoDiabetico]
