module Main where

import Data.List (elem, intersect, foldl', minimumBy)
import Data.List.Ordered (minus)
import qualified Data.Map as M
import qualified Data.Set as S

type PrimesMap =  M.Map Integer [Integer]

genPrimes :: Integer -> [Integer]
genPrimes lim = 2 : seive [3, 5 .. lim]
  where seive (p:xs)
          | p * p > lim = p : xs
          | otherwise   = p : (seive xs `minus` [p * p, p * p + 2 * p ..])

numToList :: Integer -> [Integer]
numToList n = [read [i] :: Integer | i <- show n]

listToNum :: [Integer] -> Integer
listToNum lst = read (concat $ map show lst) :: Integer

isPrime :: Integer -> Bool
isPrime n = testPrime (2 : [3,5 .. srt])
  where srt = floor . sqrt . fromIntegral $ n
        testPrime []     = True
        testPrime (x:xs) = if n `mod` x == 0
                           then False
                           else testPrime xs

makePairs :: Integer -> [Integer] -> [(Integer, Integer)]
makePairs p plst = map (\x -> (p, x)) plst

updatePrimesMap :: PrimesMap -> [(Integer,Integer)] -> PrimesMap
updatePrimesMap m []         = m
updatePrimesMap m ((a,b):xs) = updatePrimesMap (upd (upd m a b) b a) xs
  where upd m' k v = case M.lookup k m' of
                      Just lst -> if not (v `elem` lst)
                                  then M.insert k (v : lst) m'
                                  else m'
                      Nothing  -> M.insert k [v] m'

makeConcPrimesMap :: [Integer] -> PrimesMap
makeConcPrimesMap plst = fillMap plst M.empty
  where pset = S.fromList plst
        pmax = last plst
        fillMap [] m     = m
        fillMap (p:xs) m = let pairs  = makePairs p xs
                               ppairs = filter (pairIsPrime) pairs
                           in updatePrimesMap (fillMap xs m) ppairs
        pairIsPrime (a, b) = all checkIfPrime [listToNum [b, a], listToNum [a, b]]
        checkIfPrime n | n <= pmax = n `S.member` pset
                       | otherwise = isPrime n

findPairwisePrimes :: PrimesMap -> [Integer] -> [Integer] -> Int -> [[Integer]]
findPairwisePrimes _ res _    0   = [res]
findPairwisePrimes m res []   _   = []
findPairwisePrimes m res plst len = foldr step [] plst
  where step n acc =
          case M.lookup n m of
            Just olst -> let int = olst `intersect` plst in
                         acc ++ findPairwisePrimes
                                m (n : res) int (len - 1)
            Nothing   -> acc

findMinSum :: [Integer] -> Int -> [Integer]
findMinSum primes len = if not $ null l
                        then minimumBy minFn l
                        else []
  where m     = makeConcPrimesMap primes
        l     = foldr step [] $ M.toList m
        step (p, lst) acc = let res = findPairwisePrimes m [p] lst (len - 1)
                            in if not $ null res
                               then res ++ acc
                               else acc
        minFn a b = (sum a) `compare` (sum b)

main :: IO ()
main = do
  let s = findMinSum (genPrimes 10000) 5
  putStrLn $ "Min sum: " ++ (show $ sum s) ++ " " ++ (show s)
