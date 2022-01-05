module Draw (draw) where

import Constants (backgroundColor, particleColor, scale)
import Foreign.C (CFloat(CFloat), CInt(CInt))
import SDL
import State (Particle, State(..))

draw :: Renderer -> State -> IO ()
draw renderer state = do
  rendererDrawBlendMode renderer $= BlendAlphaBlend
  rendererScale renderer $= convertV2 scale
  rendererDrawColor renderer $= backgroundColor
  clear renderer
  drawParticles renderer (_particles state)
  present renderer

drawParticles :: Renderer -> [Particle] -> IO ()
drawParticles renderer = mapM_ (drawParticle renderer)

drawParticle :: Renderer -> Particle -> IO ()
drawParticle renderer particle = do
  rendererDrawColor renderer $= particleColor
  drawPoint renderer (convertIntV2 particle)

convertV2 :: V2 Float -> V2 CFloat
convertV2 (V2 x y) = V2 (CFloat x) (CFloat y)

convertIntV2 :: V2 Float -> Point V2 CInt
convertIntV2 (V2 x y) = P $ V2 (CInt $ round x) (CInt $ round y)
