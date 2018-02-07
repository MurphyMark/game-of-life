module Update exposing (..)

import Cell exposing (Cell)
import Model exposing (Model, wrap)


type Msg
    = FlipCell Cell
    | Tick
    | RunToggle


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ livingCells } as model) =
    case msg of
        FlipCell cell ->
            wrap <| flipCell cell model

        Tick ->
            wrap <| tick model

        RunToggle ->
            wrap <| toggleRun model


flipCell : Cell -> Model -> Model
flipCell cell ({ livingCells } as model) =
    let
        newCells =
            Cell.flipCell cell livingCells
    in
    { model | livingCells = newCells }


tick : Model -> Model
tick ({ width, height, livingCells } as model) =
    let
        newCells =
            Cell.updateCells width height livingCells
    in
    { model | livingCells = newCells }


toggleRun : Model -> Model
toggleRun ({ running } as model) =
    { model | running = not running }
