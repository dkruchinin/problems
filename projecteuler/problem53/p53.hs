module Main where

import Data.Array
import Data.List (foldl')

factorial :: Integer -> Integer
factorial n = foldl' step 1 [2 .. n]
  where step f i = f * i

buildFacTable :: Integer -> Array Integer Integer
buildFacTable n = array (1,n) [(i, factorial i) | i <- [1 .. n]]

binom :: Integer -> Integer -> Array Integer Integer -> Integer
binom n r ftable = (ftable ! n) `div` ((ftable ! r) * (ftable ! (n - r)))

findBinomsLessThan :: Integer -> Integer -> Integer -> [Integer]
findBinomsLessThan start end lim = filter (> lim) blst
  where ftable = buildFacTable lim
        blst   = [binom n r ftable | n <- [start .. end],
                                     r <- [2 .. n - 1]]

main :: IO ()
main = do
  putStrLn $ "--> " ++ (show $ length $ findBinomsLessThan 23 100 1000000)
