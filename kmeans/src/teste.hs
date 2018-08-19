(.-.) :: (Num a) => [a] -> [a] -> [a]
(.-.) = zipWith (-)

(.^) :: (Floating a, Functor f) => f a -> Int -> f a
xs .^ x = (^x) <$> xs

(.+.) :: (Num a) => [a] -> [a] -> [a]
(.+.) = zipWith (+)

somaVetor ::(Num a) => [[a]] -> [a]
somaVetor [[]] = []
somaVetor [[x]] = [x]
somaVetor (xs:xxs) = (.+.) xs (somaVetor xxs)
