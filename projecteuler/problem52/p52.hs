module Main where

import Data.List (sort)

numToList :: Int -> [Int]
numToList n = foldr step [] $ show n
  where step x acc = (read [x] :: Int) : acc

listToNum :: [Int] -> Int
listToNum lst = fst $ foldr step (0, 0) lst
  where step x (acc, p) = (acc + x * 10 ^ p, p + 1)

multBy :: Int -> [Int] -> [Int]
multBy n mlt = map (* n) mlt

sameDigits :: [Int] -> Bool
sameDigits nums = all (== (head l)) l
  where l = map (listToNum . sort . numToList) nums

findSmallest :: [Int] -> Int
findSmallest mltList = doFind [12 ..]
  where doFind (n:xs) = if sameDigits $ (n : multBy n mltList)
                        then n else doFind xs
