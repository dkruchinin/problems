module Main where

import Data.Ratio

median :: Ratio Integer -> Ratio Integer -> Ratio Integer
median a b =
  (numerator a + numerator b) % (denominator a + denominator b)

fracLeftTo :: Ratio Integer -> Ratio Integer -> Ratio Integer -> Ratio Integer
fracLeftTo left right fbound
  | mid < fbound = fracLeftTo mid right fbound
  | mid > fbound = fracLeftTo left mid fbound
  | otherwise    = left
  where mid = median left right

findRedP :: Ratio Integer -> Integer -> Ratio Integer
findRedP fbound dlim = fareyLoop left
  where left = fracLeftTo (0 % 1) (1 % 1) fbound
        fareyLoop l =
          let l' = median l fbound
          in if denominator l' >= dlim
             then l
             else fareyLoop l'

main :: IO ()
main = do
  putStrLn $ "Result: " ++ (show $ findRedP (3 % 7) (10 ^ 6))
