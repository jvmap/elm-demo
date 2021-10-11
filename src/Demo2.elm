module Demo2 exposing (main)

import Playground exposing (..)

main =
  animation view

view : Time -> List Shape
view time =
  [ square blue 40
      |> moveX (zigzag -100 100 2 time)
  ]