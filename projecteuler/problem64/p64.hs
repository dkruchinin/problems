module Main where

import Data.List (elem)

splitToGroups :: [a] -> Int -> [[a]]
splitToGroups []  _ = []
splitToGroups seq n = (take n seq) : (splitToGroups (drop n seq) n)

sqrtAsFraction :: Integer -> (Integer, [Integer])
sqrtAsFraction n = (a0, map (\(a,_,_) -> a) $ findSequence a0 1 0 [])
  where a0 = floor . sqrt $ fromIntegral n
        findSequence a d m s =
          let m' = d * a - m
              d' = (n - m' ^ 2) `div` d
              a' = (a0 + m') `div` d'
              t  = (a', d', m')
          in if t `elem` s
             then s
             else findSequence a' d' m' (t : s)

isPerfectSquare :: Integer -> Bool
isPerfectSquare n = n == sr ^ 2
  where sr = round . sqrt $ fromIntegral n

p64 :: Int
p64 = length $ filter (\(_,s) -> (length s) `mod` 2 /= 0) seq
  where seq = map sqrtAsFraction $ filter (not . isPerfectSquare) [1 .. 10000]

main :: IO ()
main = putStrLn $ "# fractions with odd period = " ++ (show p64)
