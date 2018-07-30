module Main where

import Data.List

data Prop = Const Bool -- constante
          | Var Char -- variável
          | Not Prop -- Não
          | And Prop Prop -- E
          | Imply Prop Prop -- Se-Então

type Subst = Assoc Char Bool

type Assoc k v = [(k,v)]

find :: Eq k => k -> Assoc k v -> v
find k t = head [v | (k',v) <- t, k == k']

p1 :: Prop
p1 = (Var 'A') `And` (Not (Var 'A'))

p2 :: Prop
p2 = ((Var 'A') `And` (Var 'B')) `Imply` (Var 'A')

p3 :: Prop
p3 = (Var 'A') `Imply` ((Var 'A') `And` (Var 'B'))

p4 :: Prop
p4 = ((Var 'A') `And` ((Var 'A') `Imply` (Var 'B'))) `Imply` (Var 'B')

-- retorna o resultado ao substituir as variáveis de uma proposição por valores booleanos.
-- crie um pattern matchin para cada possível valor de Prop
avalia :: Subst -> Prop -> Bool
avalia _ (Const b)   = b
avalia s (Var x)     = Main.find x s
avalia s (Not p)     = not (avalia s p)
avalia s (And p q)   = avalia s p && avalia s q
avalia s (Imply p q) = avalia s p <= avalia s q

vars :: Prop -> [Char]
vars (Const _)   = []
vars (Var x)     = [x]
vars (Not p)     = vars p
vars (And p q)   = vars p ++ vars q
vars (Imply p q) = vars p ++ vars q

-- remove as variáveis duplicadas da lista
uniquevars:: Eq a => [a] -> [a]
uniquevars xs = nub xs

bools :: Int -> [[Bool]]
bools 0 = [[]]
bools n = map (False :) bss ++ map (True :) bss
          where bss = bools (n-1)

-- Exemplo: substs (Var 'A') `And` (Var 'B') deve gerar
-- [[('A', False), ('B', False)], [('A', False), ('B', True)],
-- [('A', True), ('B', False)], [('A', True), ('B', True)]]
substs :: Prop -> [Subst]
substs p = map (zip vs) (bools (length vs))
           where vs = uniquevars (vars p)

isTaut :: Prop -> Bool
isTaut p = and [avalia s p | s <- substs p]

main :: IO ()
main = do
  print $ isTaut p1
  print $ isTaut p2
  print $ isTaut p3
  print $ isTaut p4
