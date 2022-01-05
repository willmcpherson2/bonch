module Main (main) where

import Constants (title)
import Control.Monad (unless)
import Draw (draw)
import Input (Input(..), Keys(..), getInput, initInput)
import SDL
import State (State, initState, update)

main :: IO ()
main = do
  initializeAll
  window <- createWindow title defaultWindow
  renderer <- createRenderer window (-1) defaultRenderer
  now <- time
  let
    state = initState
    input = initInput now
  appLoop renderer input state
  destroyWindow window
  destroyRenderer renderer

appLoop :: Renderer -> Input -> State -> IO ()
appLoop renderer input state = do
  events <- pollEvents
  now <- time
  let
    input' = getInput input now events
    state' = update input' state
  draw renderer state
  unless (_quit $ _keys input') (appLoop renderer input' state')
