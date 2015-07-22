module Main where

import Data.List (minimumBy, maximumBy, takeWhile, elem)

isDiophantine :: Integer -> Integer -> Integer -> Bool
isDiophantine x d y
  | isSquare d = False
  | otherwise  = x ^ 2 - d * y ^ 2 == 1

isSquare :: Integer -> Bool
isSquare n = n == (round . sqrt . fromIntegral $ n) ^ 2

genDiophanSolutions :: [(Integer, Integer, Integer)]
genDiophanSolutions = [(x, d, y) | x <- [1 .. ], y <- [1 .. x],
                                   let d = ((x - 1) * (x + 1)) `div` y ^ 2,
                                   isDiophantine x d y]

findDiophanSolution :: Integer -> (Integer, Integer, Integer)
findDiophanSolution d = head $ take 1 [(x, d, y)
                                    | y <- [1 ..],
                                      let y2 = y ^ 2,
                                      let x2 = 1 + d * y2,
                                      let x  = (round . sqrt) $ fromIntegral x2,
                                      x ^ 2 == x2]

takeMinDiophanSolutions :: Integer -> [(Integer, Integer, Integer)] -> [(Integer, Integer, Integer)]
takeMinDiophanSolutions dlim lst = reverse $ takeMin [] [] lst
  where limlen = length $ [i | i <- [2 .. dlim], not $ isSquare i]
        takeMin res ds []     = res
        takeMin res ds (s:ss)
                | (length ds) == 7 = res
                | otherwise = let (x,_,_) = s
                                  dups = takeWhile (\(x',_,_) -> x == x') ss
                                  xs'  = drop (length dups) ss
                                  r    = minimumBy minfn (s:dups)
                                  (_,d,_)  = r
                              in if d <= dlim && not (d `elem` ds)
                                then takeMin (r : res) (d : ds) xs'
                                else takeMin res ds xs'
        minfn (_,d1,_) (_,d2,_) = d1 `compare` d2

findMaX :: [(Integer, Integer, Integer)] -> (Integer, Integer, Integer)
findMaX = maximumBy maxfn
  where maxfn (x1,_,_) (x2,_,_) = x1 `compare` x2

main :: IO ()
main = do
  let (x, d, y) = findMaX $ takeMinDiophanSolutions 1000 genDiophanSolutions
  putStrLn $ "Max x = " ++ (show x) ++ "; " ++ (show (x, d, y))
