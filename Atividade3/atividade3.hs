raiz2Grau1 :: Floating a => a -> a -> a -> (a,a)
raiz2Grau1 a b c = ((-b+delta)/2*a,(-b-delta)/2*a)
  where
    delta = sqrt(b*b - 4.0*a*c)

raiz2Grau2 :: (Ord a, Floating a) => a -> a -> a -> (a, a)
raiz2Grau2 a b c = if (delta < 0)
  then (0,0)
  else ((-b+sqrt(delta))/2*a,(-b-sqrt(delta))/2*a)
  where
    delta = b*b - 4.0*a*c

raiz2Grau3 :: (Ord a, Floating a) => a -> a -> a -> (a, a)
raiz2Grau3 a b c
  | delta < 0 = error "Raízes negativas"
  | delta >= 0 = ((-b+sqrt(delta))/2*a,(-b-sqrt(delta))/2*a)
  where
    delta = b*b - 4.0*a*c

mediaPonderada :: (Eq a, Floating a) => a -> a -> (a -> a -> a)
mediaPonderada m1 m2 p1 p2 = if (m1+m2/=1.0)
  then error "A soma dos pesos é diferente de 1"
  else (m1*p1 + m2*p2)/(m1+m2)

converteNota :: (Ord a, Floating a) => a -> Char
converteNota a
  | a < 5 = 'F'
  | a < 6 = 'D'
  | a < 7 = 'C'
  | a < 8 = 'B'
  | a >= 8 = 'A'

conceitoFinal :: Char -> Char -> Char
conceitoFinal 'F' _ = 'F'
conceitoFinal _ 'F' = 'F'
conceitoFinal 'A' 'A' = 'A'
conceitoFinal 'B' 'B' = 'B'
conceitoFinal 'C' 'C' = 'C'
conceitoFinal 'D' 'D' = 'D'
conceitoFinal 'A' 'B' = 'A'
conceitoFinal 'A' 'C' = 'B'
conceitoFinal 'A' 'D' = 'B'
conceitoFinal 'B' 'A' = 'B'
conceitoFinal 'B' 'C' = 'B'
conceitoFinal 'B' 'D' = 'C'
conceitoFinal 'C' 'A' = 'B'
conceitoFinal 'C' 'B' = 'C'
conceitoFinal 'C' 'D' = 'D'
conceitoFinal 'D' 'A' = 'C'
conceitoFinal 'D' 'B' = 'C'
conceitoFinal 'D' 'C' = 'D'
