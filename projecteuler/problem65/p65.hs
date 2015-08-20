module Main where

import Data.Ratio

fractionalErep :: [Integer]
fractionalErep = genErep [2,4..]
  where genErep (x:xs) = [1, x, 1] ++ (genErep xs)

calcEfrac :: [Integer] -> Rational
calcEfrac seq = (toRational 2) + (calc seq)
  where calc []     = toRational 0
        calc (x:xs) = 1 / (toRational x + (calc xs))


numToList :: Integer -> [Integer]
numToList n = map (\x -> read [x] :: Integer) $ show n

main :: IO ()
main = do
  let frac = calcEfrac $ take 99 fractionalErep
  putStrLn $ "Answer: " ++ (show . sum . numToList . numerator $ frac)
