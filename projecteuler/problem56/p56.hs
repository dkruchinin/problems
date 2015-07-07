module Main where

listPows :: Integer -> Integer -> [Integer]
listPows a b = [i ^ j | i <- [11 .. a],
                   j <- [1 .. b],
                   i `mod` 10 /= 0]

sumDigits :: Integer -> Integer
sumDigits n = sum digs
  where digs = map (\x -> read [x] :: Integer) $ show n

findBiggestDigSum :: Integer -> Integer -> Integer
findBiggestDigSum a b = maximum $ map sumDigits pows
  where pows = listPows a b

main :: IO ()
main = do
  putStrLn $ "Sum: " ++ (show $ findBiggestDigSum 100 100)
