module Main where

import System.Environment
import Data.Char
import Data.Bits (xor)
import Data.List (foldl')

splitBy :: Char -> String -> [String]
splitBy sep lst = reverse $ doRec lst []
  where doRec []  res = res
        doRec seq res = let i = takeWhile (/= sep) seq
                            r = drop ((length i) + 1) seq
                        in doRec r (i : res)

makeGroups :: Int -> [a] -> [[a]]
makeGroups gsz seq = reverse $ doRec seq []
  where doRec [] res  = res
        doRec lst res = doRec (drop gsz lst) $ (take gsz lst) : res

takeColumn :: Int -> [[a]] -> [a]
takeColumn col seq = foldr step [] seq
  where step s acc | length s > col = (s !! col) : acc
                   | otherwise      = acc

xorChrCodes :: Int -> Int -> Int
xorChrCodes a b = (a ^ b) `mod` 256

isXoredSpace :: Int -> Bool
isXoredSpace c = isAlpha (chr res) || res == 0
  where res = c `xor` 32

findSpaceLocation :: [Int] -> Int
findSpaceLocation []  = -1
findSpaceLocation seq = doRec seq 0
  where len = fromIntegral $ length seq
        doRec []  _  = -1
        doRec (x:xs) i = let xorlst = map (fromIntegral . (xor x)) seq
                             c      = length $ filter isXoredSpace xorlst
                         in if (fromIntegral c) / len > 0.7
                            then i
                            else doRec xs (i + 1)

findKey :: [Int] -> Int
findKey seq = (seq !! sloc) `xor` 32
  where sloc = findSpaceLocation seq

decipher :: [Int] -> String
decipher seq = reverse . snd . foldl' glue (0, []) $ seq
  where grps = makeGroups 3 seq
        key = map (\i -> findKey $ takeColumn i grps) [0 .. 2]
        glue (i, res) c = let idx = i `mod` 3
                              sym = chr $ c `xor` (key !! idx)
                          in (i + 1, (sym : res))

main :: IO ()
main = do
  [fname] <- getArgs
  ctx     <- readFile fname
  let digs = map (\x -> read x :: Int) $ splitBy ',' ctx
  let s    = sum . map ord . decipher $ digs
  putStrLn $ "Sum is " ++ (show s)
