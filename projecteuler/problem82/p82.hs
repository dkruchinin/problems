module Main where

import System.Environment
import Control.Monad.State
import Data.List.Split (splitOn)
import qualified Data.PQueue.Min as PQ
import qualified Data.Vector as V
import qualified Data.Set as S

type Matrix        = V.Vector (V.Vector Integer)
type VisitedNodes  = S.Set (Int, Int)
data QueueItem     = QueueItem {
    itemPos    :: (Int, Int)
  , itemWeight :: Integer
} deriving (Eq, Show)
type SearchState a = State (PQ.MinQueue QueueItem) a

instance Ord QueueItem where
  compare a b = compare (itemWeight a) (itemWeight b)

mget :: Matrix -> (Int, Int) -> Integer
mget m (i, j) = (m V.! i) V.! j

dequeue :: SearchState QueueItem
dequeue = do
  (item, pq) <- gets PQ.deleteFindMin
  put pq
  return item

enqueue :: QueueItem -> SearchState ()
enqueue item = modify (PQ.insert item)

itemNeighbours :: Matrix -> VisitedNodes -> QueueItem -> [QueueItem]
itemNeighbours m vn item = map makeItem coords
  where (i,j)  = itemPos item
        weight = itemWeight item
        msize  = V.length m
        coords = filter (\(x,y) ->
                         x >= 0 && x < msize && y >= 0 && y < msize
                         && not (S.member (x,y) vn))
                 [(i+1,j), (i-1,j), (i,j+1)]
        makeItem pos = QueueItem pos (weight + mget m pos)

shortestPath :: Matrix -> VisitedNodes ->
                (Matrix -> (Int,Int) -> Bool) ->
                SearchState Integer
shortestPath m vn isDestPos = do
  item <- dequeue
  if isDestPos m (itemPos item)
    then return $ itemWeight item
    else do
      forM_ (itemNeighbours m vn item) enqueue
      shortestPath m (S.insert (itemPos item) vn) isDestPos

findMinPathSum :: Matrix -> Integer
findMinPathSum m = evalState (shortestPath m vn isDestPos) pq
  where srcVertices = [(i,0) | i <- [0 .. V.length m - 1]]
        pq = PQ.fromList $ map (\v -> QueueItem v (mget m v)) srcVertices
        vn = S.fromList srcVertices
        isDestPos m' (_,j) = j == V.length m' - 1

makeRow :: String -> V.Vector Integer
makeRow = V.fromList . map (\x -> read x :: Integer) . splitOn ","

readMatrix :: String -> IO Matrix
readMatrix fname = do
  ctx <- readFile fname
  return $ V.fromList . map makeRow . lines $ ctx

main :: IO ()
main = do
  [fname] <- getArgs
  matrix  <- readMatrix fname
  putStrLn $ "Minimal path sum: " ++ show (findMinPathSum matrix)
