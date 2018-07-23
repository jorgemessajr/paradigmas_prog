module Test where

import Data.List
import Votos

prop_ordenado ::  Ord a => [(Int,a)] -> Bool
prop_ordenado xs = resultado xs == sort (resultado xs)

prop_vazio :: Eq a => [[a]] -> Bool
prop_vazio xs = not $ elem [] $ rmvazio xs
