(.-.) :: (Num a) => [a] -> [a] -> [a]
(.-.) = zipWith (-)

(.^) :: (Floating a, Functor f) => f a -> Int -> f a
xs .^ x = (^x) <$> xs

(.+.) :: (Num a) => [a] -> [a] -> [a]
(.+.) = zipWith (+)

(./) :: (Floating a, Functor f) => f a -> a -> f a
xs ./ x = (/x) <$> xs
