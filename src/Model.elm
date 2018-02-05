module Model exposing (Model)

import Cell exposing (Cell)
import Set exposing (Set)


-- MODEL


type alias Model =
    { width : Int
    , height : Int
    , running : Bool
    , livingCells : Set Cell
    }



-- INIT


init : Model
init =
    { width = 10
    , height = 10
    , running = False
    , livingCells = Set.empty
    }
