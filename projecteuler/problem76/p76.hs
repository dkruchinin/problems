module Main where

countSums :: Int -> Int
countSums n = lst !! n
  where lst = foldr trackSummand (1:repeat 0) [1 .. n - 1]
        trackSummand s oldlst = newlst
          where newlst = (take s oldlst) ++ zipWith (+) newlst (drop s oldlst)

main :: IO ()
main = do
  putStrLn $ "100 can be written as "
             ++ (show $ countSums 100)
             ++ " different sums"
