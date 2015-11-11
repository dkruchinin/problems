module Main where

isPrime :: Int -> Bool
isPrime 1 = False
isPrime 2 = True
isPrime n = not $ divisibleBy (2 : [3, 5 .. sr])
  where sr = floor . sqrt $ fromIntegral n
        divisibleBy [] = False
        divisibleBy (x:xs) = if n `mod` x == 0
                             then True
                             else divisibleBy xs

listPrimes :: Int -> Int -> [Int]
listPrimes from to = [i | i <- [from .. to], isPrime i]

countSums :: Int -> [Int] -> Int
countSums n seq = lst !! n
  where lst = foldr trackSummand (1:repeat 0) seq
        trackSummand i oldlst = newlst
          where newlst = (take i oldlst) ++ zipWith (+) (drop i oldlst) newlst

bSearch :: Int -> Int -> (Int -> Bool) -> Maybe Int
bSearch a b pred
  | b - a == 1 = if pred b then Nothing else Just b
  | otherwise =
    let m = (a + b) `div` 2
    in if pred m then bSearch m b pred
                 else bSearch a m pred

main :: IO ()
main = do
  let lpr = listPrimes 1 100
  case bSearch 1 100 (\x -> countSums x lpr < 5000) of
    Just val -> putStrLn $ "Answer: " ++ (show val)
    Nothing  -> putStrLn "No answer found..."
