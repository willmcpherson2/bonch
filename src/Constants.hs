module Constants
  ( title
  , particleColor
  , backgroundColor
  , keyUp
  , keyDown
  , keyLeft
  , keyRight
  , keyQuit
  , repulsionSpeed
  , attractionSpeed
  , scale
  ) where

import Data.Text (Text)
import Data.Word (Word8)
import SDL

title :: Text
title = "bonch"

scale :: V2 Float
scale = 8

repulsionSpeed :: Float
repulsionSpeed = 4

attractionSpeed :: Float
attractionSpeed = 2

particleColor :: V4 Word8
particleColor = V4 255 0 0 127

backgroundColor :: V4 Word8
backgroundColor = V4 0 0 0 255

keyUp :: Keycode
keyUp = KeycodeUp

keyDown :: Keycode
keyDown = KeycodeDown

keyLeft :: Keycode
keyLeft = KeycodeLeft

keyRight :: Keycode
keyRight = KeycodeRight

keyQuit :: Keycode
keyQuit = KeycodeQ
