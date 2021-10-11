module Main exposing (main)

import Playground exposing (..)
import List exposing (map, map2)

main = demo4

demo1 =
  picture
    [ triangle green 150
    , circle white 40
    , circle black 10
    ]

demo2 =
  animation view

view : Time -> List Shape
view time =
  [ square blue 40
      |> moveX (zigzag -100 100 2 time)
  ]


-- Saying x |> f is exactly the same as f x.

demo3 =
  game view2 update (0,0)

view2 computer (x,y) =
  [ line blue 3 (-100,-100) (x,y),
    square red 40
      |> move x y
  ]

update computer (x,y) =
  ( x + 2 * toX computer.keyboard
  , y + 2 * toY computer.keyboard
  )

demo4 =
  game view3 update3 []

view3 computer points = (polyline red 2 points)
  ++ (map (\pt -> circle blue 4 |> move2 pt) points)

move2 (x, y) = move x y

polyline : Color -> Number -> List Point -> List Shape
polyline color thickness points = case points of
  [] -> []
  h::t -> map2 (line color thickness) points t

update3 computer points = if computer.mouse.click then
  (computer.mouse.x, computer.mouse.y) :: points
  else
    points

type alias Point = (Number, Number)

line : Color -> Number -> Point -> Point -> Shape
line color thickness (x1, y1) (x2, y2) =
    let
        dx = x2 - x1
        dy = y2 - y1
        length = dx * dx + dy * dy |> sqrt
        width = length
        height = thickness
        angle = atan2 dy dx
            |> (*) (180 / pi)
    in
        rectangle color width height
            |> moveX (0.5 * x1 + 0.5 * x2)
            |> moveY (0.5 * y1 + 0.5 * y2)
            |> rotate angle -- wsl. op basis van midden?
            -- |> moveX (-x1)
            -- |> moveY (-y1)