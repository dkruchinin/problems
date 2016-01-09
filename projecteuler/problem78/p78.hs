module Main where

import Data.Array

generalizedPnum :: Integer -> Integer
generalizedPnum k = (k * (3 * k - 1)) `div` 2

nextPartition :: Integer -> Integer -> Array Integer Integer -> Integer
nextPartition n m arr = calcNextPartition 0 0
  where calcNextPartition i p =
          let k    = setUpK i
              pn   = generalizedPnum k
              idx  = n - pn
              sign = if (i `mod` 4) > 1 then -1 else 1
          in if idx < 0 || idx >= n then p
             else calcNextPartition (i + 1)
                  ((p + (sign * (arr ! idx))) `mod` m)
        setUpK i = let k = i `div` 2 + 1
                   in if i `mod` 2 == 0
                      then k else -k

firstPartitionDivisibleBy :: Integer -> Integer
firstPartitionDivisibleBy d = findPartition 1
  where arr = array (0, 1000000) ([(0, 1)] ++ [(i, nextPartition i d arr)
                                                | i <- [1 .. 1000000]])
        findPartition n | (arr ! n) == 0 = n
                        | otherwise      = findPartition $ n + 1

main :: IO ()
main = do
  let p = firstPartitionDivisibleBy 1000000
  putStrLn $ "First partition divisible by 1000000 is " ++ (show p)
