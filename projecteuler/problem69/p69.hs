module Main where
import Data.List.Ordered (minus)

genPrimes :: Integer -> [Integer]
genPrimes lim = 2 : seive [3, 5 .. lim]
  where seive (p:xs)
          | p * p > lim = p : xs
          | otherwise   = p : (seive xs `minus` [p * p, p * p + 2 * p ..])

findTotient :: Integer -> Integer
findTotient n = loopAcc 1 primes
  where primes     = genPrimes (floor . sqrt $ fromIntegral n)
        loopAcc c []     = c
        loopAcc c (x:xs)
          | c * x < n = loopAcc (c * x) xs
          | otherwise = c

main :: IO ()
main = do
  putStrLn $ "Answer: " ++ (show $ findTotient 1000000)
