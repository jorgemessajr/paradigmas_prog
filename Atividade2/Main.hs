bools :: [Bool]
bools = [False, True]

nums :: [[Int]]
nums = [ [1,2,3], [4,5,6] ]

soma :: Int -> Int -> Int -> Int
soma x y z = x+y+z

copia :: a -> (a, a)
copia x = (x,x)

f :: a-> a
f x = x

g :: Eq a => a -> (a, a) -> Bool
g x (y,z) = x==y
