module Main where

import System.IO
import Data.List
import Data.Char (ord, chr)

data Pattern = Symbol Char
             | AnySymbol
             | AnySequence
             | SymbolsGroup (String, Bool)
     deriving (Show)


match :: String -> String -> Bool
match str patternStr = matchWithPattern str (compilePattern patternStr)


matchWithPattern :: String -> [Pattern] -> Bool
matchWithPattern "" [] = True
matchWithPattern _  [] = False
matchWithPattern "" [AnySequence]  = True
matchWithPattern "" [SymbolsGroup ("", _)] = True 
matchWithPattern "" _ = False
matchWithPattern (c:str) (p:pattern) = case p of
    (Symbol s)                       -> matchTwoSymbols c s str pattern
    (SymbolsGroup sgrp)              -> matchSymbolAndGroup c sgrp str pattern
    AnySymbol                        -> matchWithPattern str pattern
    AnySequence                      -> matchAnySequence (c:str) pattern


matchTwoSymbols :: Char -> Char -> String -> [Pattern] -> Bool
matchTwoSymbols a b str pattern | a == b    = matchWithPattern str pattern
                                | otherwise = False


matchAnySequence :: String -> [Pattern] -> Bool
matchAnySequence "" pattern = matchWithPattern "" pattern
matchAnySequence str [] = True
matchAnySequence (c:str) (p:pattern) | matchWithPattern str (AnySequence:(p:pattern)) = True
                                     | matchWithPattern [c] [p] = matchWithPattern str pattern
                                     | otherwise = False


matchSymbolAndGroup :: Char -> (String, Bool) -> String -> [Pattern] -> Bool
matchSymbolAndGroup c (grpseq, isNegation) str pattern = 
    doMatch (find (\x -> x == c) grpseq) isNegation
    where doMatch (Just _) False = matchWithPattern str pattern
          doMatch Nothing True   = matchWithPattern str pattern
          doMatch _ _            = False


compilePattern :: String -> [Pattern]
compilePattern "" = []
compilePattern pstr = doCompilePattern pstr []
    where doCompilePattern "" pattern = pattern
          doCompilePattern str pattern = 
            let (item, rest) = fetchOnePatternFromString str
            in item : (doCompilePattern rest pattern)


fetchOnePatternFromString :: String -> (Pattern, String)
fetchOnePatternFromString (c:str) = case c of
    '_' -> (AnySymbol, str)
    '[' -> groupOrSymbol str
    '%' -> (AnySequence, dropWhile (\x -> x == '%') str)
    _   -> (Symbol c, str)

    where groupOrSymbol str = case (findIndex (\x -> x == ']') str) of
                   Just idx -> (makeSymbolsGroup (take idx str), drop (idx + 1) str)
                   Nothing  -> (Symbol '[', str)


makeSymbolsGroup :: String -> Pattern
makeSymbolsGroup ""  = SymbolsGroup ("", False)
makeSymbolsGroup (c:str) | c == '^'  = SymbolsGroup ((composeSequnce str []), True)
                         | otherwise = SymbolsGroup ((composeSequnce (c:str) []), False)
    where composeSequnce "" grp = grp
          composeSequnce (c:rest) grp = case c of
            '-' -> handleRangeSign rest grp
            _   -> composeSequnce rest (c:grp)

          handleRangeSign "" grp  = composeSequnce "" ('-' : grp)
          handleRangeSign str ""  = composeSequnce str  "-"
          handleRangeSign str "-" = composeSequnce str "--"
          handleRangeSign (c:rest) grp = case (buildRange (head grp) c) of
            Just seq -> composeSequnce rest seq ++ (tail grp)
            Nothing  -> composeSequnce (c:rest) ('-':grp)

          buildRange from to | ord from <= ord to = 
                                   Just (foldr (\x acc -> (chr x) : acc) [] [ord from .. ord to])
                             | otherwise = Nothing


split :: String -> String -> [String]
split _ ""           = [""]
split "" _           = [""]
split pattern string = doSplit string [[]] plen
    where doSplit "" parts _ = reverse (map (reverse) parts)
          doSplit (c:str) (x:xs) plen = if (take plen (c:str)) == pattern 
            then doSplit (drop (plen - 1) str) ([]:(x:xs)) plen
            else doSplit str ((c:x):xs) plen
          plen = length pattern


fetchArgument :: String -> (String, String)
fetchArgument ""  = ("", "")
fetchArgument str = doFetchArgument str ""
    where doFetchArgument "" arg                  = (reverse arg, str)
          doFetchArgument ('\'':('\'':str)) arg   = doFetchArgument str ('\'':arg)
          doFetchArgument (c:str) arg | c /= '\'' = doFetchArgument str (c:arg)
                                      | otherwise = (reverse arg, str)


getArguments :: String -> (String, String)
getArguments "" = ("", "")
getArguments str = let (firstArg, rest) = fetchArgument (tail str)
                       (secondArg, _)   = fetchArgument (drop 7 rest)
                   in (firstArg, secondArg)


main :: IO ()
main = do
    numLines <- getLine
    processLines (read numLines :: Int)


processLines :: Int -> IO ()
processLines numLines = mapM_ processLine [1 .. numLines]
    where processLine _ = do
            line <- getLine
            if matchWithPattern (getArguments line)
                then putStrLn "YES"
                else putStrLn "NO"
          matchWithPattern (str, pattern) = match str pattern
