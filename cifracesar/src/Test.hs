module Test where
import Cesar

-- aplicando shift duas vezes, uma com o valor negativo, o caracter deve ser o mesmo
prop_neg_shift :: Int -> Char -> Bool
prop_neg_shift n c = shift n (shift (-n) c) == c

-- o tamanho da mensagem codificada deve ser o mesmo da original
prop_enc_length :: Int -> String -> Bool
prop_enc_length n xs = length(encode n xs) == length(xs)
