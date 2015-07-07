module Main where

import Data.List (foldl')

reverseNum :: Integer -> Integer
reverseNum n = read rev :: Integer
  where rev = reverse $ show n

isPalindrome :: Integer -> Bool
isPalindrome n = n == reverseNum n

isLychrelNum :: Integer -> Int -> Bool
isLychrelNum n iters = doTestNum n 1
  where doTestNum x i
          | i >= iters = True
          | otherwise  = let s = x + (reverseNum x)
                         in if isPalindrome s
                            then False
                            else doTestNum s (i + 1)

listLychrelNumsBelow :: Integer -> [Integer]
listLychrelNumsBelow lim = filter (\x -> isLychrelNum x 50) [10 .. lim]

main :: IO ()
main = do
  putStrLn $ "# Lychrel numbers below 10000 = " ++
             (show $ length (listLychrelNumsBelow 10000))
