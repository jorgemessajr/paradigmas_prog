--Definição da Fila, necessária para a implementação da função caminhoAumentador

data Fila a = Fila [a] deriving(Show)

insere::a->Fila a->Fila a
insere x (Fila xs) = Fila (xs ++ [x])

remove:: Fila a -> (a, Fila a)
remove (Fila xs) = (head xs, Fila $ tail xs)

zera:: Fila a -> Fila a
zera (Fila xs) = Fila ([])

estaVazia::Fila a-> Bool
estaVazia (Fila []) = True
estaVazia (Fila xs) = False

tuple1thFila::(Elemento a, Fila (Elemento a))->Elemento a
tuple1thFila (x,_) = x

tuple2thFila::(Elemento a, Fila (Elemento a))->Fila (Elemento a)
tuple2thFila (_,x) = x

tuple1th::(Bool, [a], [a], [a], Fila (Elemento a))->Bool
tuple1th (x,_,_,_,_) = x

tuple2th::(Bool, [a], [a], [a], Fila (Elemento a))->[a]
tuple2th (_,x,_,_,_) = x

tuple3th::(Bool, [a], [a], [a],Fila (Elemento a))->[a]
tuple3th (_,_,x,_,_) = x

tuple4th::(Bool, [a], [a], [a], Fila (Elemento a))->[a]
tuple4th (_,_,_,x,_) = x

tuple5th::(Bool, [a], [a], [a], Fila (Elemento a))->Fila (Elemento a)
tuple5th (_,_,_,_,x) = x

tuple1thCam::(Bool, [a], [a], [a])->Bool
tuple1thCam (x,_,_,_) = x

tuple2thCam::(Bool, [a], [a], [a])->[a]
tuple2thCam (_,x,_,_) = x

atualizaLista::(Num a, Eq a, Ord a)=>a->a->[a]->[a]
atualizaLista _ _ [] = []
atualizaLista pos valor (x:xs)
  |pos == 0 = [valor] ++ xs
  |otherwise = [x] ++ atualizaLista (pos-1) valor xs

retornaElemento::(Num a, Eq a, Ord a)=>a->[a]->a
retornaElemento _ [] = -2
retornaElemento a (x:xs)
  |a == 0 = x
  |otherwise = retornaElemento (a-1) xs

data Cor = Branco | Preto deriving (Show, Eq)
type Noh             = (Int,Cor)
type Viz             = [Int]
type Elem           = (Noh,Viz)
data Elemento a = Elemento Elem deriving(Show)

corElemento::Elemento a->Cor
corElemento (Elemento xs) = snd $ fst xs

vizinhosElemento::(Num a, Eq a, Ord a)=>Elemento a->[a]
vizinhosElemento (Elemento xs) = map (fromIntegral) (snd xs)

numeroElemento::(Num a, Eq a, Ord a)=>Elemento a->a
numeroElemento (Elemento xs) = fromIntegral(fst $ fst xs)

igualChave::(Num a, Eq a, Ord a)=>a->Elemento a->Bool
igualChave k (Elemento xs) = if (k == x) then True else False
  where
    x = fromIntegral (fst $ fst xs)

ehCor::Cor->Elemento a->Bool
ehCor cor (Elemento xs) = if corElemento (Elemento xs) == cor then True else False

ehSolteiro::(Num a, Eq a, Ord a)=>[a]->Elemento a->Bool
ehSolteiro match xs  = cond
  where
    elem = numeroElemento xs
    valor = retornaElemento elem match
    cond = valor == -1



retornaListaFila::(Num a, Eq a, Ord a)=>Fila (Elemento a)->[a]
retornaListaFila (Fila xs) = map (numeroElemento) xs

data Grafo a = Grafo [a] deriving(Show)

insereGrafo::a->Grafo a->Grafo a
insereGrafo x (Grafo xs) = Grafo (xs ++ [x])

numeroElementos::Grafo a->Int
numeroElementos (Grafo xs) = length xs

retornaFilaGrafo::(Num a, Eq a, Ord a)=>Grafo (Elemento a)->Cor->[a]->Fila (Elemento a)
retornaFilaGrafo (Grafo xs) cor match = Fila (cs)
  where
    bs = filter (ehCor cor) xs
    cs = filter (ehSolteiro match) bs


freeLista::(Num a, Eq a, Ord a)  =>[a]->[a]
freeLista [] = []
freeLista [x] = [-1]
freeLista (x:xs) = [-1] ++ freeLista xs

visitaElementos::(Num a, Eq a, Ord a)  => [a]->[a]->[a]
visitaElementos [] xs = xs
visitaElementos _ [] = []
visitaElementos _ [x] = [x]
visitaElementos (x:xs) ys = visitaElementos xs lista
  where
    lista = atualizaLista x 1 ys

setaPais::(Num a, Eq a, Ord a)  => [a]->[a]->[a]
setaPais [] xs = xs
setaPais _ [] = []
setaPais _ [x] = [x]
setaPais (x:xs) ys = setaPais xs lista
  where
    lista = atualizaLista x x ys

novoEmparelhamento::(Num a, Eq a, Ord a)  => [a]->[a]->a->[a]
novoEmparelhamento pa xs t = if t_1 == x then emp'' else novoEmparelhamento pa emp'' t_1
  where
    x = retornaElemento t pa
    emp' = atualizaLista t x xs
    emp'' = atualizaLista x t emp'
    t_1 = retornaElemento x pa


tentaEmparelhamento::(Num a, Eq a, Ord a)  =>[a]->[a]->a->(Bool,[a])
tentaEmparelhamento pa xs elem = if match == -1 then (True, (novoEmparelhamento pa xs elem)) else (False, xs)
  where
    match = retornaElemento elem xs

visitaElemento::(Num a, Eq a, Ord a)=>Grafo (Elemento a)->Fila (Elemento a)-> a->a->[a]->[a]->[a]->(Bool,[a],[a],[a], Fila (Elemento a))
visitaElemento (Grafo xs) fs v w match visitados pais = if visitado == 0 then (cond, novoMatch, novoVisitados', novoPais', novaFila')
                                                          else (False, match, visitados, pais, fs)
  where
    visitado = retornaElemento w visitados
    novoPais = atualizaLista w v pais
    novoVisitados = atualizaLista w 1 visitados
    emp = tentaEmparelhamento novoPais match w
    novoMatch = snd emp
    x = retornaElemento w match
    cond = fst (emp)
    novoVisitados' = if cond then freeLista visitados else atualizaLista x 1 novoVisitados
    novoPais' = if cond then freeLista novoPais' else atualizaLista x w novoPais
    elementoFila = filter (igualChave x) xs ---Arrumar aqui
    novaFila = insere (head elementoFila) fs --Arrumar aqui
    novaFila' = if cond then zera fs else novaFila
--novaFila = if x /= -1 then insere (head elementoFila) fs else fs--Arrumar aqui
    --paisVazios = freeLista novoPais'


analisaVizinhos::(Num a, Eq a, Ord a)=>Grafo (Elemento a)->Fila (Elemento a)-> a->[a]->[a]->[a]->[a]->(Bool,[a],[a],[a], Fila (Elemento a))
analisaVizinhos grafo fila v [] match visitados pais = (False,match,visitados,pais, fila)
analisaVizinhos grafo fila v (x:xs) match visitados pais = if cond == True then (True,novoMatch,novoVisitados,novoPais, novaFila) else analisaVizinhos grafo novaFila v xs novoMatch novoVisitados novoPais
  where
    aux = visitaElemento grafo fila v x match visitados pais
    cond = tuple1th aux
    novoMatch = tuple2th aux
    novoVisitados = tuple3th aux
    novoPais = tuple4th aux
    novaFila = tuple5th aux

analisaFila::(Num a, Eq a, Ord a)=>Grafo (Elemento a)->Fila (Elemento a)->[a]->[a]->[a]->(Bool,[a],[a],[a])
analisaFila grafo fila match visitados pais = if ehVazia then (False,match,visitados,pais)
                                              else if cond == True then (cond,novoMatch,novoVisitados,novoPais)
                                              else analisaFila grafo novaFila' novoMatch novoVisitados novoPais
  where
    ehVazia = estaVazia fila
    pop = remove fila
    x = numeroElemento (tuple1thFila pop)
    novaFila = tuple2thFila pop
    v = vizinhosElemento (tuple1thFila pop)
    aux = analisaVizinhos grafo novaFila x v match visitados pais
    cond = tuple1th aux
    novoMatch = tuple2th aux
    novoVisitados = tuple3th aux
    novoPais = tuple4th aux
    novaFila' = tuple5th aux


caminhoAumentador::(Num a, Eq a, Ord a)=>Grafo (Elemento a)->[a]->Cor->(Bool,[a])
caminhoAumentador grafo match cor = (cond, match')
  where
    pais =      [-1 | x <- [1..(numeroElementos grafo)]]
    visitados = [0 | y <- [1..(numeroElementos grafo)]]
    fila =      retornaFilaGrafo grafo Branco match
    listaElem = retornaListaFila fila
    visitados' = visitaElementos listaElem visitados
    pais' = setaPais listaElem pais
    result = analisaFila grafo fila match visitados' pais'
    match' = tuple2thCam result
    cond = tuple1thCam result

emparelhamentoMaximo::(Num a, Eq a, Ord a)=>Grafo (Elemento a) -> [a] ->Cor->Int->(Int, [a])
emparelhamentoMaximo grafo match cor size = if cond ==True then emparelhamentoMaximo grafo novoMatch cor novoSize else (size, match)
  where
    aux = caminhoAumentador grafo match cor
    cond = fst aux
    novoMatch = snd aux
    novoSize = size + 1
