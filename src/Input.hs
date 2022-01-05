module Input (Input(..), Time, Clock(..), Keys(..), initInput, getInput) where

import Constants (keyDown, keyLeft, keyQuit, keyRight, keyUp)
import SDL
import Types (Time)

data Input = Input
  { _keys :: Keys
  , _clock :: Clock
  }
  deriving Show

data Clock = Clock
  { _now :: Time
  , _delta :: Time
  }
  deriving Show

data Keys = Keys
  { _up :: Bool
  , _down :: Bool
  , _left :: Bool
  , _right :: Bool
  , _quit :: Bool
  }
  deriving Show

initInput :: Time -> Input
initInput now = Input
  { _keys = Keys
    { _up = False
    , _down = False
    , _left = False
    , _right = False
    , _quit = False
    }
  , _clock = Clock { _now = now, _delta = now - now }
  }

getInput :: Input -> Time -> [Event] -> Input
getInput input now events = Input
  { _keys = getKeys (_keys input) events
  , _clock = Clock { _now = now, _delta = now - _now (_clock input) }
  }

getKeys :: Keys -> [Event] -> Keys
getKeys = foldl getKeysForEvent

getKeysForEvent :: Keys -> Event -> Keys
getKeysForEvent Keys { _up, _down, _left, _right, _quit } event = Keys
  { _up = getKeyInput event _up keyUp
  , _down = getKeyInput event _down keyDown
  , _left = getKeyInput event _left keyLeft
  , _right = getKeyInput event _right keyRight
  , _quit = getKeyInput event _quit keyQuit
  }

getKeyInput :: Event -> Bool -> Keycode -> Bool
getKeyInput event prev keycode =
  eventHasKeyAndMotion event keycode Pressed || prev && not
    (eventHasKeyAndMotion event keycode Released)

eventHasKeyAndMotion :: Event -> Keycode -> InputMotion -> Bool
eventHasKeyAndMotion event keycode motion = case eventPayload event of
  KeyboardEvent keyboardEvent ->
    keyboardEventKeyMotion keyboardEvent
      == motion
      && keysymKeycode (keyboardEventKeysym keyboardEvent)
      == keycode
  _ -> False
