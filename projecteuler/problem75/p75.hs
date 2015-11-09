module Main where

import Control.Monad
import Control.Monad.Reader
import Control.Monad.ST
import qualified Data.Vector as V
import qualified Data.Vector.Mutable as VM

type MyState s = ReaderT (VM.MVector s Int) (ST s)

trackCandidate :: Int -> Int -> Int -> MyState s ()
trackCandidate c i lim
  | c * i > lim = return ()
  | otherwise   =
    do let k = c * i
       vec <- ask
       val <- lift $ VM.read vec (k - 1)
       lift $ VM.write vec (k - 1) (val + 1)
       trackCandidate c (i + 1) lim

usePairs :: [(Int, Int)] -> Int -> MyState s ()
usePairs []           _   = return ()
usePairs ((m,n):rest) lim
  | (m - n) `mod` 2 == 0 || gcd m n > 1 = usePairs rest lim
  | otherwise =
  let ms = m ^ 2
      ns = n ^ 2
      a = ms - ns
      b = 2 * m * n
      c = ms + ns
  in do trackCandidate (a + b + c) 1 lim
        usePairs rest lim

genPtriples :: Int -> V.Vector Int
genPtriples n = runST $ do
  vec <- VM.replicate n 0
  let lim   = floor . sqrt . fromIntegral $ n
  let pairs = [(i,j) | i <- [2 .. lim], j <- [1 .. i - 1]]
  runReaderT (usePairs pairs n) vec
  V.freeze vec

main :: IO ()
main = do
  let count = V.length $ V.filter (== 1) $ genPtriples 1500000
  putStrLn $ "Number of one iteger sided right triangels below 1500000: "
           ++ (show count)
