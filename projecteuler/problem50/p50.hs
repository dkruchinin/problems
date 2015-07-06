module Main where

import qualified Data.Set as S

isPrime :: Int -> Bool
isPrime 1 = False
isPrime 2 = True
isPrime n = not $ divisibleBy (2 : [3, 5 .. sr])
  where sr = floor . sqrt $ fromIntegral n
        divisibleBy [] = False
        divisibleBy (x:xs) = if n `mod` x == 0
                             then True
                             else divisibleBy xs

listPrimes :: Int -> Int -> [Int]
listPrimes from to = [i | i <- [from .. to], isPrime i]

longestSumBelow :: Int -> (Int, Int)
longestSumBelow lim = doFindSum primes (0, 0)
  where primes    = listPrimes 1 lim
        primesSet = S.fromList primes
        doFindSum []  res    = res
        doFindSum lst (s, c) =
          let (s', c') = longestSum lst 0 0 (0, 0)
              rest     = tail lst
          in if c' > c
             then doFindSum rest (s', c')
             else doFindSum rest (s, c)
        longestSum []     _ _ res    = res
        longestSum (x:xs) s i (p, c) =
          let s' = s + x
              i' = i + 1
          in
          if (s' > lim) then (p, c)
          else if S.member s' primesSet
               then longestSum xs s' i' (s', i)
               else longestSum xs s' i' (p,  c)

main :: IO ()
main = do
  putStrLn $ "-> " ++ (show longestSumBelow 1000000)
