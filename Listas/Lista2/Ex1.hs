penultimo :: [a] -> a
penultimo xs
  | (length xs) == 0 = error "Lista Vazia"
  | (length xs) == 1 = error "Lista com um elemento"
  | otherwise =  xs !! n
  where
    n = ((length xs)-2)

maximoLocal :: [Int] -> [Int]
maximoLocal (x:y:z:xs) =  if (y > x && y > z) then y : maximoLocal(y:z:xs)
                          else maximoLocal(y:z:xs)
maximoLocal _          = []

divisores :: Int -> [Int]
divisores n = [x | x <- [1..(n-1)], n `mod` x  == 0 ]

perfeito ::  Int -> Bool
perfeito n = if sum(divisores n) == n then True
                else False

perfeitos :: Int -> [Int]
perfeitos n = [x | x <- [1..n], perfeito x]

produtoEscalar :: Num a => [a] -> [a] -> a
produtoEscalar xs ys = sum[x*y | (x,y) <- zip xs ys]

palindromo :: [Int] -> Bool
palindromo xs = xs == reverse xs

ordenaListas :: (Num a, Ord a) => [[a]] -> [[a]]
ordenaListas []     = []
ordenaListas (p:xs) = (ordenaListas lesser) ++ [p] ++ (ordenaListas greater)
    where
        lesser  = [x | x<- xs, (length x) < length p]
        greater = [x | x<- xs, (length x) >= length p]

digitosRev :: Int -> [Int]
digitosRev n
  |n==0       = []
  |otherwise  = [n `mod` 10] ++ digitosRev (n `div` 10)

dobroAlternado :: [Int] -> [Int]
dobroAlternado xs = [if y `mod` 2 == 0 then x*2 else x | (x,y) <- zip xs [1..length(xs)]]

somaDigitos :: [Int] -> Int
somaDigitos xs
  |xs==[]     = 0
  |otherwise  = sum(digitosRev(head(xs))) + somaDigitos(tail(xs))

luhn :: Int -> Bool
luhn n = if somatoria `mod` 10 == 0 then True else False
  where
    listaInversa = digitosRev(n)
    dobro = dobroAlternado(listaInversa)
    somatoria = somaDigitos(dobro)
