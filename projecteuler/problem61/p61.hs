module Main where

import qualified Data.Map as M

triagonal :: Integer -> Integer
triagonal n = n * (n + 1) `div` 2

square :: Integer -> Integer
square n = n ^ 2

pentagonal :: Integer -> Integer
pentagonal n = n * (3 * n - 1) `div` 2

hexagonal :: Integer -> Integer
hexagonal n = n * (2 * n - 1)

heptagonal :: Integer -> Integer
heptagonal n = n * (5 * n - 3) `div` 2

octagonal :: Integer -> Integer
octagonal n = n * (3 * n - 2)

genAllNDigNums :: Int -> (Integer -> Integer) -> [Integer]
genAllNDigNums nd fn = collect $ map fn [1 ..]
  where collect (n:xs)
          | len > nd  = []
          | len == nd = n : (collect xs)
          | otherwise = collect xs
          where len = length $ show n

takeIntPrefix :: Integer -> Int -> Integer
takeIntPrefix n d =  read (take d $ show n) :: Integer

takeIntPostfix :: Integer -> Int -> Integer
takeIntPostfix n d =  read (drop d $ show n) :: Integer

buildMap :: [Integer] -> M.Map Integer [Integer]
buildMap lst = doBuildMap lst M.empty
  where doBuildMap [] m     = m
        doBuildMap (x:xs) m =
          let pref = takeIntPrefix x 2
          in case M.lookup pref m of
              Just seq -> doBuildMap xs $ M.insert pref (x : seq) m
              Nothing  -> doBuildMap xs $ M.insert pref [x] m

lookupInMaps :: Integer -> [M.Map Integer [Integer]] -> [([Integer], M.Map Integer [Integer])]
lookupInMaps k []      = []
lookupInMaps k (m:mps) = case M.lookup k m of
                          Just v  -> (v, m) : lookupInMaps k mps
                          Nothing -> lookupInMaps k mps

findSequnces :: [Integer] -> [M.Map Integer [Integer]]  -> [[Integer]]
findSequnces seq []   = [seq]
findSequnces seq maps = foldr doFind [] seq
  where doFind x acc =
          let subseqs = map (\(lst, m) -> findSequnces lst $ filter (/= m) maps)
                        $ lookupInMaps (takeIntPostfix x 2) maps
          in if not $ null subseqs
             then acc ++ (map (\s -> x : s) $ concat subseqs)
             else acc

findCyclicSequences :: Int -> [[Integer]]
findCyclicSequences nd = filter isCyclic $ findSequnces trSeq maps
   where trSeq = genAllNDigNums nd triagonal
         maps  = map (\fn -> buildMap $ genAllNDigNums nd fn)
                 [square, pentagonal, hexagonal, heptagonal, octagonal]
         isCyclic g = takeIntPostfix (last g) 2 == takeIntPrefix (head g) 2

main :: IO ()
main = do
  let seqs = findCyclicSequences 4
  if not $ null seqs
    then putStrLn $ "Sequence " ++ (show $ head seqs) ++ "; sum = "
                    ++ (show $ (sum . head) seqs)
    else putStrLn "No suitable sequence found"
