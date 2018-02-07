module View exposing (..)

import Cell exposing (Cell)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model)
import Set exposing (Set)
import Update exposing (Msg(..))


view : Model -> Html Msg
view { width, height, running, livingCells } =
    let
        cells =
            cellsView width height livingCells
    in
    div [ class "container" ]
        [ cells
        , button [ class "tick", onClick Tick ] [ text "Tick" ]
        , runButtonView running
        ]


runButtonView : Bool -> Html Msg
runButtonView running =
    let
        buttonText =
            if not running then
                "Start"
            else
                "Stop"
    in
    button
        [ class "start", onClick RunToggle ]
        [ text buttonText ]


cellsView : Int -> Int -> Set Cell -> Html Msg
cellsView width height livingCells =
    let
        rowCells : Int -> Int -> Set Cell
        rowCells width row =
            Cell.cellSet ( 0, row ) ( width, row )

        rowList =
            List.range 0 height
                |> List.map (rowView livingCells << rowCells width)
    in
    div
        [ class "cells" ]
        rowList


rowView : Set Cell -> Set Cell -> Html Msg
rowView livingCells rowCells =
    let
        cellList =
            rowCells
                |> Set.toList
                |> List.map (\c -> cellView (Cell.alive c livingCells) c)
    in
    div [ class "cell-row" ]
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
