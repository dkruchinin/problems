module Main where

import Data.Ratio
import Data.Array

median :: Ratio Integer -> Ratio Integer -> Ratio Integer
median a b =
  (numerator a + numerator b) % (denominator a + denominator b)

fareyLength :: Integer -> Ratio Integer -> Ratio Integer
               -> Ratio Integer -> Integer
fareyLength n prev cur lim = doCount a b c d 0
  where a  = numerator prev
        b  = denominator prev
        c  = numerator cur
        d  = denominator cur
        ln = numerator lim
        ld = denominator lim
        doCount a b c d count =
          if c == ln && d == ld
          then count
          else let k = (n + b) `div` d
               in doCount c d (k * c - a) (k * d - b) (count + 1)

findFareyRatioNextTo :: Ratio Integer -> Ratio Integer
                        -> Integer -> Ratio Integer
findFareyRatioNextTo left right dlim
  | denominator m <= dlim = findFareyRatioNextTo left m dlim
  | otherwise             = right
  where m = median left right


main :: IO ()
main = do
  let n    = 12000
  let next = findFareyRatioNextTo (1%3) (1%2) n
  putStrLn $ "Farey length from 1/3 to 1/2 for n = " ++ (show n) ++
             " is " ++ (show $ fareyLength n (1%3) next (1%2))
