mc91 :: Integral a => a -> a
mc91 n = if n > 100 then n - 10 else mc91(mc91(n+11))

elem' :: Eq a => a -> [a] -> Bool
elem' _ [] = False
elem' e (x:xs) = if e == x then True else elem' e xs

euclid :: Int -> Int -> Int
euclid x y
  |x == y = y
  |y < x = y
  |otherwise = euclid x (y-x)

concat' :: [[a]] -> [a]
concat' [[]] = []
contat' (x:xs) = x ++ concat' xs

intersperse' :: a -> [a] -> [a]
intersperse' _ [] = []
intersperse' s (x:xs) = if length xs == 0 then x : []
                        else x : s : intersperse' s xs



takeNth :: Int -> [a] -> [a]
takeNth _ [] = []
takeNth n xs = go n xs
  where
    maxSize = length xs
    go count xs
      | n > maxSize || count > maxSize = []
      | otherwise = xs !! (count-1) : go (count + n) xs

penultimo :: [a] -> a
penultimo [] = error "Lista vazia"
penultimo [x] = error "Lista com um elemento"
penultimo (x:_:[]) = x
penultimo (x:xs) = penultimo (xs)
