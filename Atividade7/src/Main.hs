--Reposta: (Alemanha,Verde,Zebra,Cafe,Prince)

--1. Existem cinco casas.
--2. O inglês mora na cada vermelha.
--3. O Sueco tem um cachorro.
--4. O dinamarquês bebe chá.
--5. A casa verde está imediatamente a esquerda da casa branca.
--6. Eles bebem café na casa verde.
--7. O homem que fuma Pall Mall tem um pássaro.
--8. Na casa amarela eles fumam Dunhill.
--9. Na casa do meio eles bebem leite.
--10. O norueguês mora na primeira casa.
--11. O homem que fuma Blend mora na casa ao lado da casa com gatos.
--12. Em uma casa ao lado da casa com um cavalo, eles fumam Dunhill.
--13. O homem que fuma Blue Master bebe cerveja.
--14. O Alemão fuma Prince.
--15. O norueguês mora na casa ao lado da casa azul.
--16. Eles bebem água na casa ao lado da casa de quem fuma Blend.



module Main where

import Control.Monad
import Control.Applicative
import Data.List

data Nacao =  Inglaterra | Suecia | Dinamarca | Alemanha | Noruega
  deriving (Eq, Show, Enum, Bounded)

data Cor = Vermelha | Verde | Branca | Amarela | Azul
  deriving (Eq, Show, Enum, Bounded)

data Pet = Cachorro | Passaro | Gato | Cavalo | Zebra
  deriving (Eq, Show, Enum, Bounded)

data Bebida = Cha | Cafe | Leite | Cerveja | Agua
  deriving (Eq, Show, Enum, Bounded)

data Cigarro = PallMall | Dunhill | Blend | Prince | BlueMaster
  deriving (Eq, Show, Enum, Bounded)

perms :: (Bounded a, Enum a) => [[a]]
perms = permutations [minBound..maxBound]

mesmaCasa :: (Eq a, Eq b) => a -> [a] -> b -> [b] -> Bool

mesmaCasa x' [] y' ys = False
mesmaCasa x' xs y' [] = False
mesmaCasa x' (x:xs) y' (y:ys) = if x'==x && y'==y then True
                                else mesmaCasa x' xs y' ys

aEsquerdaDe :: (Eq a, Eq b) => a -> [a] -> b -> [b] -> Bool
aEsquerdaDe x' (x:xs) y' (y:ys) = mesmaCasa x' (x:xs) y' ys

aoLadoDe :: (Eq a, Eq b) => a -> [a] -> b -> [b] -> Bool
aoLadoDe x xs y ys = (aEsquerdaDe x xs y ys) || (aEsquerdaDe y ys x xs)

casaMeio :: (Eq a) => a -> [a] -> Bool
casaMeio x' xs =  if x' == xs !! (((l + 1) `div` 2)-1) then True
                  else False
  where
    l = length xs

primeiraCasa :: (Eq a) => a -> [a] -> Bool
primeiraCasa x' xs =  if x' == head xs then True
                      else False

solucoes = do
  p   <- perms :: [[Pet]]
  cig <- perms :: [[Cigarro]]
  n   <- perms :: [[Nacao]]
  c   <- perms :: [[Cor]]
  b   <- perms :: [[Bebida]]

  guard $ mesmaCasa Inglaterra n Vermelha c   --2
  guard $ mesmaCasa Suecia n Cachorro p       --3
  guard $ mesmaCasa Dinamarca n Cha b         --4
  guard $ aEsquerdaDe Verde c Branca c        --5
  guard $ mesmaCasa Cafe b Verde c            --6
  guard $ mesmaCasa PallMall cig Passaro p    --7
  guard $ mesmaCasa Dunhill cig Amarela c     --8
  guard $ casaMeio Leite b                    --9
  guard $ primeiraCasa Noruega n              --10
  guard $ aoLadoDe Blend cig Gato p           --11
  guard $ aoLadoDe Dunhill cig Cavalo p       --12
  guard $ mesmaCasa BlueMaster cig Cerveja b  --13
  guard $ mesmaCasa Alemanha n Prince cig     --14
  guard $ aoLadoDe Noruega n Azul c           --15
  guard $ aoLadoDe Agua b Blend cig           --16

  return (n,c,p,b,cig)

main :: IO ()
main = do print (head [zip5 n c p b cig | (n,c,p,b,cig) <- solucoes])
