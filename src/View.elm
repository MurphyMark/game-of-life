module View exposing (..)

import Cell exposing (Cell)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg exposing (Msg(..))
import Set exposing (Set)


rowView : Set Cell -> Set Cell -> Html Msg
rowView rowCells livingCells =
    let
        rowList =
            rowCells
                |> Set.toList
                |> List.map (\c -> cellView (Cell.alive c livingCells) c)
    in
    div [ class "cellRow" ]
        rowList


cellView : Bool -> Cell -> Html Msg
cellView living cell =
    span
        [ classList
            [ ( "cell", True )
            , ( "alive", living )
            , ( "dead", not living )
            ]
        , onClick (FlipCell cell)
        ]
        []
