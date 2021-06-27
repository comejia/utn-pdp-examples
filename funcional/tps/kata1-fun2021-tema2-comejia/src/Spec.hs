module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Test de calculín2" $ do
    it "si el primer número es menor que el segundo, devuelve el doble del primer número " $ do
      calculin2 5 6 `shouldBe` 10
    it "si no, si el primer número es par, devuelve el segundo número multiplicado por el primero" $ do
      calculin2 8 4 `shouldBe` 32
    it "en caso contrario, devuelve la suma del primer número y la mitad entera del segundo" $ do
      calculin2 9 8 `shouldBe` 13

