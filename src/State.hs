module State (State(..), Particle, initState, update) where

import Constants (attractionSpeed, repulsionSpeed)
import Input (Clock(..), Input(..), Time)
import SDL
import Util (mapWithOthers)

type Particle = V2 Float

data State = State
  { _particles :: [Particle]
  }
  deriving Show

initState :: State
initState = State
  { _particles =
    [V2 4.5 2.5, V2 18.9 36.8, V2 62.5 6.0, V2 85.3 69.0, V2 60.0 29.5]
  }

update :: Input -> State -> State
update Input { _clock = Clock { _delta } } State { _particles } =
  let particles' = mapWithOthers (force _delta) _particles
  in State { _particles = particles' }

force :: Time -> [Particle] -> Particle -> Particle
force delta particles particle = foldr go particle particles
  where
    go other particle =
      let
        towards = normalize $ other - particle
        away = negate towards
        attraction = towards ^* attractionSpeed ^* delta
        repulsion = away ^* (repulsionSpeed / distance particle other) ^* delta
      in particle + attraction + repulsion
