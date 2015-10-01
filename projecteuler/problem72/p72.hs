module Main where

import Data.Ratio
import Data.Array

fareyLength :: Integer -> Integer
fareyLength n = table ! n
  where table         = listArray (1, n) (2 : map countLength [2..n])
        countLength i = ((i + 3) * i) `div` 2 -
                        (sum $ map (\d -> table ! (i `div` d)) [2 .. i])

main :: IO ()
main = do
  let l = fareyLength 1000000
  putStrLn $ "# of reduced proper fractions <= 1000000 is " ++ (show $ l - 2)
