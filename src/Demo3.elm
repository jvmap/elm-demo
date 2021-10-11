module Demo3 exposing (main)

import Playground exposing (..)

main =
  game view update (0,0)

view computer (x,y) =
  [ square red 40
      |> move x y
  ]

update computer (x,y) =
  ( x + 2 * toX computer.keyboard
  , y + 2 * toY computer.keyboard
  )