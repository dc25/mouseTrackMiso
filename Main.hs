{-# LANGUAGE RecordWildCards            #-}
module Main where

import           Control.Arrow
import           Miso
import           Debug.Trace

trunc = truncate *** truncate

main :: IO ()
main = startApp App {..}
  where
    initialAction = Id
    model         = Model (0,0)
    update        = updateModel
    view          = viewModel
    events        = defaultEvents
    subs          = [ mouseSub HandleMouse ]
    mountPoint    = Nothing

updateModel :: Action -> Model -> Effect Action Model

updateModel (HandleMouse newCoords) model =
  noEff model { mouseCoords = trace (show newCoords) newCoords }

updateModel Id model = noEff model

data Action
  = HandleMouse (Int, Int)
  | Id

newtype Model
  = Model
  { mouseCoords  :: (Int, Int)
  } deriving Eq

viewModel :: Model -> View Action
viewModel (Model (x,y)) =
  div_ [ ] [ ]

