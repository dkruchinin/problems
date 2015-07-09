module Main where

isPrime :: Integer -> Bool
isPrime 1 = False
isPrime 2 = True
isPrime n = not $ divisibleBy (2 : [3, 5 .. lim])
  where lim = floor . sqrt $ fromIntegral n
        divisibleBy []     = False
        divisibleBy (x:xs) = if n `mod` x == 0
                             then True
                             else divisibleBy xs

calcPrimes :: [Integer] -> Int
calcPrimes []  = 0
calcPrimes lst = length $ filter isPrime lst

genSquareDiags :: [[Integer]]
genSquareDiags = map genDiags [3, 5 ..]
  where genDiags n = foldr (\_ res -> ((head res) - n + 1) : res)
                     [n ^ 2] [1 .. 3]

problem58 :: Integer
problem58 = doRec 0 1 genSquareDiags
  where doRec p t (x:xs) = let t' = t + length x
                               p' = p + calcPrimes x
                           in if calcRatio p' t' < 0.1
                              then floor . sqrt . fromIntegral $ last x
                              else doRec p' t' xs
        calcRatio a b    = fromIntegral a / fromIntegral b

main :: IO ()
main = do
  putStrLn $ "Answer: " ++ (show problem58)
