module View exposing (..)

import Cell exposing (Cell)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg exposing (Msg(..))
import Set exposing (Set)


cellsView : Int -> Int -> Set Cell -> Html Msg
cellsView width height livingCells =
    let
        rowCells : Int -> Int -> Set Cell
        rowCells width row =
            Cells.cellSet ( 0, row ) ( width, row )

        rowList =
            List.range 0 height
                |> List.map (rowView livingCells << rowCells width)
    in
    div [ class "cells" ]
        rowList


rowView : Set Cell -> Set Cell -> Html Msg
rowView livingCells rowCells =
    let
        cellList =
            rowCells
                |> Set.toList
                |> List.map (\c -> cellView (Cell.alive c livingCells) c)
    in
    div [ class "cellRow" ]
        cellList


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
