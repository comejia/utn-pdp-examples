module Spec where
import PdePreludat
import Library
import Test.Hspec

-- Test Data
chocolateAmargo = Chocolate "Muy amargo" [] 10 70 20
chocolateAmargoYAptoDiabetico = Chocolate "Muy amargo" [] 10 70 0
chocolateConMuchosIngredientes = Chocolate "El mejor" ["cacao", "limon", "naranja", "pera", "mani"] 10 30 20
chocolateConPocosIngredientes = Chocolate "Simple" ["cacao", "limon"] 10 30 20


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

