module Main where

import Data.List (minimumBy, maximumBy, takeWhile, elem, cycle)

isDiophantine :: Integer -> Integer -> Integer -> Bool
isDiophantine x d y
  | isSquare d = False
  | otherwise  = x ^ 2 - d * y ^ 2 == 1

isSquare :: Integer -> Bool
isSquare n = n == (round . sqrt . fromIntegral $ n) ^ 2

sqrtAsFraction :: Integer -> (Integer, [Integer])
sqrtAsFraction n = (a0, map (\(a,_,_) -> a) $ reverse $ findSequence a0 1 0 [])
  where a0 = floor . sqrt $ fromIntegral n
        findSequence a d m s =
          let m' = d * a - m
              d' = (n - m' ^ 2) `div` d
              a' = (a0 + m') `div` d'
              t  = (a', d', m')
          in if t `elem` s
             then s
             else findSequence a' d' m' (t : s)

findDiophanSolution :: Integer -> (Integer, Integer, Integer)
findDiophanSolution d = findSolution a0 1 1 0 $ cycle seq
  where (a0, seq) = sqrtAsFraction d
        findSolution x x' y y' (ai:rest) =
          if isDiophantine x d y then (x, d, y)
          else findSolution (ai * x + x') x (ai * y + y') y rest

main :: IO ()
main = do
  let sols = map findDiophanSolution $ filter (not . isSquare) [1 .. 1000]
  let res = maximumBy (\(a,_,_) (b,_,_) -> compare a b) sols
  putStrLn $ "Solution: " ++ (show res)
