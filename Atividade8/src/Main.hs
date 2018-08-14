import Control.Monad
import Control.Applicative
import Data.List

type Pos = (Int, Int)

largura :: Int
largura = 10

altura :: Int
altura = 10

type Board = [Pos]

glider :: Board
glider = [(4,2),(2,3),(4,3),(3,4),(4,4)]

cls :: IO ()
cls = putStr "\ESC[2J"

goto :: Pos -> IO ()
goto (x, y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

writeAt :: Pos -> String -> IO ()
writeAt p xs = do goto p
                  putStr xs

showCells :: Board -> IO [()]
showCells b = sequenceA (map (\x-> writeAt x "o") b)

isAlive :: Board -> Pos -> Bool
isAlive b p = elem p b

isEmpty :: Board -> Pos -> Bool
isEmpty b p = not $ isAlive b p

neighbs :: Pos -> [Pos]
neighbs (x,y) = map wrap [(x,y-1),(x-1,y-1),(x-1,y),(x-1,y+1),(x,y+1),(x+1,y+1),(x+1,y),(x+1,y-1)]

wrap :: Pos -> Pos
wrap (x, y) = (((x-1) `mod` largura) + 1, ((y-1) `mod` altura) + 1)

liveNeighbs :: Board -> Pos -> Int
liveNeighbs b p = length xs
  where
    xs = filter (isAlive b) neighbors
    neighbors = neighbs p

regra1 :: Board -> Pos -> Bool
regra1 b p = n==2 || n==3
  where n = liveNeighbs b p

survivors :: Board -> [Pos]
survivors b = filter (regra1 b) b

births :: Board -> [Pos]
births b = [p | p <- nub (concat (map neighbs b)),
                    isEmpty b p,
                    liveNeighbs b p == 3]

nextGen :: Board -> Board
nextGen b = survivors b ++ births b

life :: Board -> IO ()
life b = do cls
            showCells b
            wait 100000 -- ajuste para seu PC
            life (nextGen b)

wait :: Int -> IO [()]
wait n = sequenceA [return () | _ <- [1..n]]

main :: IO ()
main = life glider
