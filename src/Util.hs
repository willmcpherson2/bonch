module Util (traceMsg, mapWithOthers) where

import Debug.Trace (trace)

traceMsg :: Show a => String -> a -> a
traceMsg msg x = trace (msg ++ show x) x

mapWithOthers :: ([a] -> a -> b) -> [a] -> [b]
mapWithOthers f xs = go f [] xs
  where
    go f xs ys = case ys of
      [] -> []
      y : ys -> f (xs ++ ys) y : go f (xs ++ [y]) ys
