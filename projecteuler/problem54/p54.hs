module Main where

import System.Environment
import Data.Ord
import Data.List

data Suit  = Hearts | Diamonds | Clubs | Spades
  deriving (Show, Eq)

data Value = Jack | Queen | King | Ace | CNum Int
  deriving (Show, Eq)

instance Ord Value where
  a `compare` b = (valueToInt a) `compare` (valueToInt b)

data HandClass = HighCard Value
               | OnePair Value
               | TwoPairs Value
               | ThreeOfAKind Value
               | Straight Value
               | Flush Value
               | FullHouse Value
               | FourOfAKind Value
               | StraightFlush Value
               | RoyalFlush
               deriving (Show, Eq, Ord)


valueToInt :: Value -> Int
valueToInt (CNum n) = n
valueToInt Jack     = 11
valueToInt Queen    = 12
valueToInt King     = 13
valueToInt Ace      = 14

cardsAtHand :: Int
cardsAtHand = 5

makeCardNum :: Char -> Value
makeCardNum c = if n >= 2 && n <= 9
                then CNum n
                else error $ "Bad card number: " ++ (show n)
  where n = read [c] :: Int

parseValue :: Char -> Value
parseValue c = case c of
                'J' -> Jack
                'Q' -> Queen
                'K' -> King
                'A' -> Ace
                'T' -> CNum 10
                _   -> makeCardNum c


parseSuit :: Char -> Suit
parseSuit c = case c of
                'H' -> Hearts
                'D' -> Diamonds
                'C' -> Clubs
                'S' -> Spades

parseCard :: String -> (Value, Suit)
parseCard (v:s:[]) = (parseValue v, parseSuit s)
parseCard _        = error $ "Bad card format"

getSuits :: [(Value, Suit)] -> [Suit]
getSuits = map snd

getVals :: [(Value, Suit)] -> [Value]
getVals = map fst

consequetive :: [Value] -> Bool
consequetive vals = cons == [0, 1, 2, 3, 4]
  where f    = valueToInt $ head vals
        cons = map (\x -> (valueToInt x) - f) vals

stopIfOnePair :: [[Value]] -> HandClass
stopIfOnePair vg
  | length p == 2 = OnePair $ head p
  | otherwise     = HighCard $ maximum $ concat vg
  where p = head vg

stopIfTwoPairs :: [[Value]] -> HandClass
stopIfTwoPairs vg
  | arePairs && (head p1) /= (head p2) = TwoPairs $ max (head p1) (head p2)
  | otherwise                          = stopIfOnePair vg
  where p1 = head vg
        p2 = head $ tail vg
        arePairs = length p1 == 2 && length p2 == 2

stopIfThreeOfAKind :: [[Value]] -> HandClass
stopIfThreeOfAKind vg
  | length f == 3 = ThreeOfAKind $ head f
  | otherwise     = stopIfTwoPairs vg
  where f = head vg

stopIfStraight :: [[Value]] -> HandClass
stopIfStraight vg
  | consequetive vals = Straight $ last vals
  | otherwise         = stopIfThreeOfAKind vg
  where vals = sort $ concat vg

stopIfFullHouse :: [[Value]] -> HandClass
stopIfFullHouse vg =
  if length first == 3 && length second == 2
  then FullHouse $ head first
  else stopIfStraight vg
  where first  = head vg
        second = head $ tail vg

stopIfFourOfAKind :: [[Value]] -> HandClass
stopIfFourOfAKind vg = if (length $ head vg) == 4
                       then FourOfAKind $ head (head vg)
                       else stopIfFullHouse vg

stopIfStraightFlush :: [[Value]] -> HandClass
stopIfStraightFlush vg =
  if consequetive vals
  then StraightFlush l
  else Flush l
  where vals = sort $ concat vg
        l    = last vals

stopIfRoyalFlush :: [[Value]] -> HandClass
stopIfRoyalFlush vg = if (sort $ concat vg) == comb
                 then RoyalFlush
                 else stopIfStraightFlush vg
  where comb = [CNum 10, Jack, Queen, King, Ace]

classify :: [(Value, Suit)] -> HandClass
classify h = if sameSuit
  then stopIfRoyalFlush groups
  else stopIfFourOfAKind groups
  where sameSuit = length (nub $ getSuits h) == cardsAtHand
        vals     = getVals h
        groups   = reverse $ sortBy cmpFn . group . sort $ vals
        cmpFn a b = (length a) `compare` (length b)

splitHands :: String -> ([(Value, Suit)], [(Value, Suit)])
splitHands s = (left, right)
  where cards = map parseCard $ words s
        left  = take cardsAtHand cards
        right = drop cardsAtHand cards

calcPlayer1Wins :: [([(Value, Suit)], [(Value, Suit)])] -> Int
calcPlayer1Wins hands = foldr countWins 0 hands
  where countWins (l, r) w = let cl = classify l
                                 cr = classify r
                             in if cl `compare` cr == GT
                                then w + 1 else w

main :: IO ()
main = do
  [fname] <- getArgs
  ctx <- readFile fname
  let hands = map splitHands $ lines ctx
  putStrLn $ "Player 1 wins: " ++ (show $ calcPlayer1Wins hands)
