module Votos where

import Data.List

votos :: [String]
votos = ["Vermelho", "Azul", "Verde", "Azul", "Azul", "Vermelho"]

votosRanks :: [[String]]
votosRanks = [["Vermelho", "Verde"], ["Azul"], ["Verde", "Vermelho", "Azul"], ["Azul", "Verde", "Vermelho"], ["Verde"]]

-- conta quantos votos o candidato x recebeu
conta :: Eq a => a -> [a] -> Int
conta c []  = 0
conta c (x:xs) = if c==x then 1+(conta c xs) else 0 + (conta c xs)

unicos :: Eq a => [a] -> [a]
unicos x = nub x

-- retorna uma lista de pares ordenados (votos, candidato) com o total de votos obtido por cada candidato
-- use a função sort para ordenar do menos para o mais votado
resultado :: Ord a => [a] -> [(Int,a)]
resultado xs = sort [ (conta x xs, x) | x <- unicos xs]

-- retorna o vencedor da eleição
vencedor :: Ord a => [a] -> a
vencedor xs = snd (vetor !! (length(vetor)-1))
  where
    vetor = resultado xs

-- elimina as listas vazias de uma lista de listas
rmvazio :: Eq a => [[a]] -> [[a]]
rmvazio = filter (/= [])

-- elimina um candidato da lista de votos
elimina :: Eq a => a -> [[a]] -> [[a]]
elimina c = map (filter (/= c))

-- retorna uma lista dos candidatos existentes, do menos para o mais votado
rank :: Ord a => [[a]] -> [a]
rank = map snd . resultado . map head

vencedor' :: Ord a => [[a]] -> a
vencedor' xs = case rank (rmvazio xs) of
  [c] -> c
  (c:cs) -> vencedor' (elimina c xs)
