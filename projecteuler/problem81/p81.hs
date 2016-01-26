module Main where

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

isDestPos :: Matrix -> (Int, Int) -> Bool
isDestPos m (i,j) = i == j && i == V.length m - 1

itemNeighbours :: Matrix -> VisitedNodes -> QueueItem -> [QueueItem]
itemNeighbours m vn item = map makeItem coords
  where (i,j)  = itemPos item
        weight = itemWeight item
        msize  = V.length m
        coords = filter (\(x,y) ->
                         x < msize && y < msize && not (S.member (x,y) vn))
                 [(i+1,j), (i, j+1)]
        makeItem pos = QueueItem pos (weight + mget m pos)

shortestPath :: Matrix -> VisitedNodes -> SearchState Integer
shortestPath m vn = do
  item <- dequeue
  if isDestPos m (itemPos item)
    then return $ itemWeight item
    else do
      forM_ (itemNeighbours m vn item) enqueue
      shortestPath m (S.insert (itemPos item) vn)

findMinPathSum :: Matrix -> Integer
findMinPathSum m = evalState (shortestPath m vn) pq
  where pq = PQ.fromList [QueueItem (0,0) (mget m (0,0))]
        vn = S.fromList [(0,0)]

makeRow :: String -> V.Vector Integer
makeRow = V.fromList . map (\x -> read x :: Integer) . splitOn ","

readMatrix :: String -> IO Matrix
readMatrix fname = do
  ctx <- readFile fname
  return $ V.fromList . map makeRow . lines $ ctx

main :: IO ()
main = putStrLn "done"
