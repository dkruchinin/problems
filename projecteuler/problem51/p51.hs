module Main where

import Data.Maybe
import Data.List (foldl', group, sort)
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

listToNum :: [Int] -> Int
listToNum lst = fst $ foldr step (0, 0) lst
  where step x (acc, p) = (acc + x * 10 ^ p, p + 1)

numToList :: Int -> [Int]
numToList n = foldr step [] $ show n
  where step x acc = (read [x] :: Int) : acc

rmDups :: [Int] -> [Int]
rmDups lst = foldr step [] lst
  where step x acc | x `elem` acc = acc
                   | otherwise    = x : acc

hasDupDigits :: Int -> Bool
hasDupDigits = any (\x -> length x >= 2) . group . numToList

vecDiff :: [Int] -> [Int] -> [Int]
vecDiff v1 v2 = map (\(a, b) -> abs $ a - b) $ zip v1 v2

hashVecDistance :: [Int] -> [Int] -> Int
hashVecDistance from to =  hashVec from diff (length diff - 1) 0
  where diff = vecDiff from to
        hashVec []     _      _ h = h
        hashVec (f:fr) (d:dr) i h =
          if d == 0 && f /= 0
            then hashVec fr dr (i - 1) (h + 10 ^ i)
            else hashVec fr dr (i - 1) h

findGroupDigits :: [Int] -> [Int]
findGroupDigits l = map head g
  where g = filter (\x -> length x >= 2) . group . sort $ l

longestPrimeFamily :: [Int] -> Int -> S.Set Int -> [Int]
longestPrimeFamily l g pSet = filter (`S.member` pSet) variants
  where variants = (listToNum l) : (foldr step [] [g + 1 .. 9])
        step d acc =
          let n = map (\x -> if x == g then d else x) l
          in (listToNum n) : acc

findPrimeFamilies :: Int -> Int -> [Int]
findPrimeFamilies ndigs reqLen = doRec primes
  where primes  = listPrimes (10 ^ (ndigs - 1)) (10 ^ ndigs - 1)
        pSet   = S.fromList primes
        doRec []     = []
        doRec (p:xs) =
          let l     = numToList p
              gDigs = filter (<= 2) $ findGroupDigits l
              v     = map (\x -> longestPrimeFamily l x pSet) gDigs
              v'    = filter (\x -> length x == reqLen) v
          in if null v' then doRec xs else (head v')

main :: IO ()
main = do
  putStrLn $ "--> " ++  (show $ findPrimeFamilies 6 8)
