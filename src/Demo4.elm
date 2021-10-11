module Demo4 exposing (main)

import Playground exposing (..)
import List exposing (map, map2)

main =
  game view update []

view computer points = (polyline red 2 points)
  ++ (map (\pt -> circle blue 4 |> move2 pt) points)

move2 (x, y) = move x y

polyline : Color -> Number -> List Point -> List Shape
polyline color thickness points = case points of
  [] -> []
  h::t -> map2 (line color thickness) points t

update computer points = if computer.mouse.click then
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
            |> rotate angle