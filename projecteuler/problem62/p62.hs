module Main where

import Data.List (nub, permutations, sort)
import qualified Data.Set as S

isCube :: Integer -> Bool
isCube n = n == cr ^ 3
  where cr = round $ (fromIntegral n) ** (1/3)

cube :: Integer -> Integer
cube n = n ^ 3

intPermutations :: Integer -> [Integer]
intPermutations n = map (\x -> read x :: Integer) $
                    filter (\(x:_) -> x /= '0') $
                    permutations str
  where str = show n
        l   = length str

genCubes :: Int -> [Integer]
genCubes nd = collectCubes $ map cube [1 ..]
  where collectCubes (c:cs)
          | l < nd    = collectCubes cs
          | l == nd   = c : collectCubes cs
          | otherwise = []
          where l = length $ show c

isPermutation :: Ord a => [a] -> [a] -> Bool
isPermutation a b = sort a == sort b

findCube :: Int -> Int -> Maybe Integer
findCube nd np = doFind cubes
  where cubes         = genCubes nd
        normalize n   = read (sort $ show n) :: Integer

        doFind []     = Nothing
        doFind (x:xs)
          | length perms == np = Just x
          | otherwise           = doFind xs
          where perms = filter (\y -> isPermutation (show x) (show y)) cubes

p62 :: Integer
p62 = doFind [8 ..]
  where doFind (x:xs) = case findCube x 5 of
                        Just n  -> n
                        Nothing -> doFind xs

main :: IO ()
main = do
  putStrLn $ "The cube is: " ++ (show p62)
