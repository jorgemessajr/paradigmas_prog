{-
Código-fonte para resolver o quebra-cabeça lógico:
http://logicgridpuzzles.com/puzzles/show_logic.php?ID=55

Crie um novo código para resolver o seu quebra-cabeça.
-}
import Data.List (permutations, intersperse)

-- se os atributos forem nomes, use a seguinte estrutura
data Name = Deans | Jones | Jeeves
            deriving (Show, Enum, Eq)
data Role = Secretary | Veterinary | Poet
            deriving (Show, Enum, Eq)
data Motive = Fun | Jewels | Candelabra
            deriving (Show, Enum, Eq)


-- gera as permutações dos valores possíveis
namePerms = permutations [Deans ..]
rolePerms = permutations [Secretary ..]
motivePerms = permutations [Fun ..]

-- gera todas as combinações de valores para as três pessoas
-- zip3 funciona igual zip, mas para três listas, gerando lista de triplas
combinações = [ zip3 p1 p2 p3 | p1 <- namePerms,
                          p2 <- rolePerms,
                          p3 <- motivePerms
        ]

-- funções para recuperar o valor de cada atributo
name (s,_,_) = s
role  (_,p,_) = p
motive    (_,_,c) = c

-- funções para recuperar os atributos de cada nome
bb [a1, _, _] = a1
bh [_, a2, _] = a2
lt [_, _, a3] = a3

-- operador Se booleano
True ==> True  = True
True ==> False = False
_    ==> _     = True

-- regras sobre cada atributo
r1 a = (role a == Poet) ==> (motive a == Candelabra)
r2 a = (name a == Jones) ==> not (motive a == Candelabra)
r3 a = (name a == Jeeves) ==> (motive a == Fun)
r4 a = (name a == Deans) ==> not (role a == Secretary)

-- regras sobre um nome especifico (posicional)
r5 as = name (bb as) /= Jeeves
r6 as = name (bb as) /= Deans
r7 as = role (bb as) /= Secretary
r8 as = role (bh as) /= Secretary
r9 as = motive (lt as) /= Candelabra
r10 as = name (bh as) /= Jeeves

-- aplica as regras condicionais e posicionais
condicional r as = all r as
posicional  r as = r as

-- gera as soluções que atendam as regras
soluções = [c | c <- combinações,
                condicional r1 c,
                condicional r2 c,
                condicional r3 c,
                condicional  r4 c,
                posicional  r5 c,
                posicional  r6 c,
                posicional  r7 c,
                posicional  r8 c,
                posicional  r9 c
           ]

-- funções para imprimir o resultado
nomes = [("Burglar Bill", bb), ("Babyface Hannah", bh), ("Larry the Thief", lt)]

printName a = "- " ++ (show $ name a)
printRole    a = "- " ++ (show $ role a)
printMotive  a = "- " ++ (show $ motive a)

printFrase (n, a) = concat
                  $ intersperse " "
                  $ [n, printName a, printRole a, printMotive a]

imprime s = unlines
          $ [printFrase (n, (f s)) | (n,f) <- nomes]

main = do
  mapM_ (putStr . imprime) soluções
