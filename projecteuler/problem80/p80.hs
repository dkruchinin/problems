module Main where

import Data.Number.CReal -- numbers package

fpDigits :: CReal -> Int -> [Integer]
fpDigits n ndigs = map (\c -> read [c] :: Integer) $ show n'
  where n' = floor $ n * 10 ^ (ndigs - 1)

perfectSquare :: Integer -> Bool
perfectSquare n = n - nrt ^ 2 == 0
  where nrt = floor . sqrt . fromIntegral $ n

findFpDigsSum :: Integer -> Int -> Integer
findFpDigsSum lim ndigs = foldr sumUp 0
                          $ filter (not . perfectSquare) [1 .. lim]
  where sumUp n s = sum $ s : fpDigits (sqrt . fromIntegral $ n) ndigs

main :: IO ()
main = do
  let s = findFpDigsSum 100 100
  putStrLn $ "Sum of first 100 digits of first 100 natural numbers: "
             ++ show s
