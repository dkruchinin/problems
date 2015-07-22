module Main where

genPowers :: Int -> [Integer]
genPowers p = collect [i ^ p | i <- [1 ..]]
  where collect (n:ns)
          | l < p     = collect ns
          | l == p    = n : (collect ns)
          | otherwise = []
          where l = length $ show n

main :: IO ()
main = do
  let ans = concat . takeWhile (not . null) $ map genPowers [1 ..]
  putStrLn $ (show $ length ans) ++ "; lst = " ++ (show ans)
