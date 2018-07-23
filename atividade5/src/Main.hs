module Main where

import Votos
import Test.QuickCheck
import Test

main :: IO ()
main = do
  print $ vencedor votos
  print $ vencedor' votosRanks
  quickCheck prop_ordenado
  quickCheck prop_vazio
