module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Tests de auto veloz" $ do
    it "Si el modelo del auto tiene cantidad impar de letras, es un auto veloz" $ do
      autoVeloz ("Renault Sandero", 10500) `shouldBe` True
    it "Si el modelo del auto tiene cantidad par de letras, no es un auto veloz" $ do
      autoVeloz ("Dodge 1500", 9000) `shouldBe` False
  
  describe "Tests de cambio de aceite" $ do
    it "Si el auto tiene mas de 10.000 kms, hay que cambiar aceite" $ do
      cambioDeAceite ("Renault Sandero", 10500) `shouldBe` True
    it "Si el auto tiene 10.000 kms o menos, no hay que cambiar aceite" $ do
      cambioDeAceite ("Dodge 1500", 9000) `shouldBe` False

