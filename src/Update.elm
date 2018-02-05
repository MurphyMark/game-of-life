module Update exposing (..)

import Cell
import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> Model
update msg ({ livingCells } as model) =
    case msg of
        FlipCell cell ->
            Cell.flipCell cell livingCells
