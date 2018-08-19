{-# LANGUAGE BangPatterns #-}
module KMeansPar where

import Data.List
import Data.Function
import Control.Parallel.Strategies
import Data.Array
import Control.DeepSeq


type Ponto = [Double]
type Cluster = [Double]
data ChunksOf a = ChunksOf [a]

-- divide cada elemento de xs por x
(./) :: (Floating a, Functor f) => f a -> a -> f a
xs ./ x = (/x) <$> xs

-- eleva cada elemento de xs por x
(.^) :: (Floating a, Functor f) => f a -> Int -> f a
xs .^ x = (^x) <$> xs

-- soma dois vetores elemento-a-elemento
(.+.) :: (Num a) => [a] -> [a] -> [a]
(.+.) = zipWith (+)

-- subtrai dois vetores elemento-a-elemento
(.-.) :: (Num a) => [a] -> [a] -> [a]
(.-.) = zipWith (-)

length' :: Num b => [a] -> b
length' xs = fromIntegral $ length xs


assign :: [Cluster] -> [Ponto] -> Array Int [Ponto]
assign cs ps = accumArray (flip (:)) [zeroCluster] (0, k-1)
                      [(argmin (distancias p), p) | p <- ps]
   where
     distancias p = map (euclid p) cs
     euclid   p c = sqrt(sum(((.^) ((.-.) p c) 2)))
     argmin    xs = fst $ minimumBy (compare `on` snd) $ zip [0..] xs
     zeroCluster  = replicate (length $ head ps) 0
     k            = length cs

somaVetor :: (Num a) =>[[a]] -> [a]
somaVetor xs = map sum . transpose $ xs

somaClusters :: Array Int [Ponto] -> [(Cluster, Double)]
somaClusters arr = map (tupla) (assocs arr)
  where
    tupla tup = ( (somaVetor (snd tup)), length' (snd tup))

step :: [Cluster] -> [Ponto] -> [(Cluster, Double)]
step cs ps  = force cs'  -- força avaliação para não deixar o trabalho pra thread principal
  where
    cs' = somaClusters $ assign cs ps

kmeans :: Int -> ChunksOf [Ponto] -> [Cluster] -> [Cluster]
kmeans it (ChunksOf pss) cs = 
