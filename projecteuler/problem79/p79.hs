module Main where

import System.Environment
import Data.List (nub, intersect, (\\))
import Data.Maybe (fromMaybe)
import qualified Data.Map as M

type ParentsMap = M.Map Int [Int]

lineToDigits :: String -> [Int]
lineToDigits = map (\c -> read [c] :: Int)

dbFromFile :: String -> IO [[Int]]
dbFromFile fname = do
  ctx <- readFile fname
  return $ map lineToDigits $ lines ctx

uniqueDigits :: [[Int]] -> [Int]
uniqueDigits = nub . concat

makeParentsMap :: [[Int]] -> ParentsMap
makeParentsMap db = foldr trackEntry M.empty db
  where trackEntry (a:b:c:rs) m  = addParent (addParent m c b) b a
        addParent m item parent =
          let parents = fromMaybe [] $ M.lookup item m
          in M.insert item (nub (parent : parents)) m

matchDigitByParrents :: [Int] -> ParentsMap -> [Int] -> Int
matchDigitByParrents pmatch _ []             =
  error $ "Failed match next digit: " ++ (show pmatch)
matchDigitByParrents pmatch pmap (x:xs) =
  if length (pmatch `intersect` parents) == length parents
  then x else matchDigitByParrents pmatch pmap xs
    where parents = fromMaybe [] $ M.lookup x pmap


reconstruct :: [[Int]] -> [Int]
reconstruct db = reverse $ loop 0 (makeParentsMap db) digits []
  where digits  = nub $ concat db
        ndigits = length digits

        loop i pmap digs seq
          | i >= ndigits = seq
          | otherwise    =
            let d = matchDigitByParrents seq pmap digs
            in loop (i + 1) (M.delete d pmap) (digs \\ [d]) (d : seq)

main :: IO ()
main = do
  [fname] <- getArgs
  db <- dbFromFile fname
  let passcode = concat . map show $ reconstruct db
  putStrLn $ "Passcode: " ++ passcode
