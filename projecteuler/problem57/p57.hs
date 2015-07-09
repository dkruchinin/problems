module Main where

import Data.Ratio

listFractions :: Int -> [Rational]
listFractions iters = reverse $ doGen 0 (1 % 2) []
  where doGen i d lst =
          if i >= iters then lst
          else let d' = (1 % 1) / (2 + d)
                   f  = 1 + d
                   in doGen (i + 1) d' (f : lst)

problem57 :: Int
problem57 = length . filter flt $ listFractions 1000
  where flt f = length (show $ numerator f) > length (show $ denominator f)

main :: IO ()
main = do
  putStrLn $ "# fractions = " ++ (show problem57)
