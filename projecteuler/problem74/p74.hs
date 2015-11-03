module Main where

import Control.Monad.State
import Control.Monad.Trans.List
import Data.List (elemIndex)
import qualified Data.Map as M

type FcMap     = M.Map Integer Integer
type FcState a = State FcMap a

trackNewCycle :: [Integer] -> Integer -> FcMap -> FcMap
trackNewCycle [] _ m = m
trackNewCycle (x:xs) c m = trackNewCycle xs c (M.insert x c m)

fcycleLength :: Integer -> [Integer] -> FcState Integer
fcycleLength n s  = do
  m <- get
  case M.lookup n m of
    Just count -> return count
    Nothing    ->  case elemIndex n s of
                      Just idx -> do let lst = take (idx + 1) s
                                     let len = toInteger $ length lst
                                     modify $ trackNewCycle lst len
                                     return 0
                      Nothing  -> do
                                     c <- fcycleLength (factorialOfDigits n) (n : s)
                                     modify $ trackNewCycle [n] $ c + 1
                                     return $ c + 1

countChains :: Integer -> [Integer] -> FcState Integer
countChains _        []  = do return 0
countChains chainLen (x:xs) = do
  cl <- fcycleLength x []
  r  <- countChains chainLen xs
  if cl == chainLen
  then return $ r + 1
  else return r

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial a = a * factorial (a - 1)

splitNumToDigits :: Integer -> [Integer]
splitNumToDigits = map (\x -> read [x] :: Integer) . show

factorialOfDigits :: Integer -> Integer
factorialOfDigits = sum . map factorial . splitNumToDigits

main :: IO ()
main = do
  let res = fst $ runState (countChains 60 [1 .. 1000000]) $ M.empty
  putStrLn $ show res
