module Main where

import Data.List (sort, (\\))

listToNum :: [Int] -> Int
listToNum lst = fst $ foldr step (0, 0) lst
  where step x (acc, p) = (acc + x * 10 ^ p, p + 1)

numToList :: Int -> [Int]
numToList n = foldr step [] $ show n
  where step x acc = (read [x] :: Int) : acc

isPrime :: Int -> Bool
isPrime n = not $ divisibleBy (2 : [3, 5 .. sr])
  where sr = floor . sqrt $ fromIntegral n
        divisibleBy [] = False
        divisibleBy (x:xs) = if n `mod` x == 0
                             then True
                             else divisibleBy xs


listPrimes :: Int -> Int -> [Int]
listPrimes from to = [i | i <- [from .. to], isPrime i]

findProgression :: Int -> [(Int, Int)] -> [Int]
findProgression n dlst = reverse $ doRec 1 []
  where doRec i res = case lookup (n * i) dlst of
                        Just x  -> doRec (i + 1) (x : res)
                        Nothing -> res

allProgressions :: [Int] -> [[Int]]
allProgressions []         = []
allProgressions [a]        = []
allProgressions (x:xs) =  (filter (\x -> length x > 2) progs)
                          ++ allProgressions xs
  where diffs = map (subtract x) xs
        assoc = zip diffs xs
        progs = map (\n -> x : (findProgression n assoc)) diffs

isPermutation :: Int -> Int -> Bool
isPermutation x p = transform x == transform p
  where transform = sort . numToList

findPermutations :: Int -> [Int] -> [Int]
findPermutations p lst = foldr findp [p] lst
  where findp n res = if isPermutation n p
                      then n : res
                      else res

findSequence :: Int -> [[Int]]
findSequence ndigs = doFindSeq primes []
  where minNum     = 10 ^ (ndigs - 1)
        maxNum     = 10 ^ ndigs - 1
        primes     = listPrimes minNum maxNum
        doFindSeq [] res     = res
        doFindSeq (p:xs) res = let perms = findPermutations p xs
                                   xs'   = xs \\ perms
                               in if length perms > 2
                               then doFindSeq xs' (res ++ allProgressions (sort perms))
                               else doFindSeq xs' res

main :: IO ()
main = do
  putStrLn $ "--> " ++ (show $ findSequence 4)
