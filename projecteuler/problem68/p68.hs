module Main where

import Data.List

pairs :: [Integer] -> [[Integer]]
pairs seq = doPairs seq
  where doPairs []         = []
        doPairs [a]        = [[a, head seq]]
        doPairs (x:(y:ys)) = [x, y] : (doPairs (y:ys))

arrange :: [[Integer]] -> [Integer] -> [[Integer]]
arrange vs res = map (\(r,v) -> r : v) $ doArrange $ zip res vs
  where m = minimum res
        doArrange (x:xs)
          | fst x == m = x : xs
          | otherwise  = doArrange (xs ++ [x])

handleGroup :: [Integer] -> [Integer] -> [[[Integer]]]
handleGroup grp seq = foldr step [] seq'
  where seq'       = seq \\ grp
        variants   = pairs grp
        step x acc =
          let s     = (sum (head variants)) + x
              diffs = map (\y -> s - (sum y)) $ tail variants
              res   = x : diffs
          in if (length res == (length $ nub res)) &&
                (res `intersect` seq' == res)
             then (arrange variants res) : acc
             else acc


listToNum :: [Integer] -> Integer
listToNum lst = read (concat $ map show lst) :: Integer

main :: IO ()
main = do
  let res = concat $ map (\g -> handleGroup g [6 .. 10])
            $ permutations [1..5]
  let nums = nub $ map (\s -> listToNum $ map listToNum s) res
  putStrLn $ "Answer: " ++ (show $ maximum nums)
