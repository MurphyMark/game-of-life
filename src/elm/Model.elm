module Model exposing (..)

import Cell exposing (Cell)
import Set exposing (Set)


-- MODEL


type alias Model =
    { width : Int
    , height : Int
    , running : Bool
    , livingCells : Set Cell
    }


wrap : Model -> ( Model, Cmd msg )
wrap model =
    ( model, Cmd.none )



-- INIT


init : ( Model, Cmd msg )
init =
    wrap <|
        { width = 25
        , height = 25
        , running = False
        , livingCells = Set.empty
        }
