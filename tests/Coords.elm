module Coords exposing (..)

import Expect
import Model exposing (willLive)
import Test exposing (..)


suite : Test
suite =
    describe "Coord functions"
        [ describe "willLive with living cell"
            [ test "Dies with less than 2 neighbors" <|
                \_ ->
                    willLive True 1
                        |> Expect.equal False
            , test "Lives with 2 - 4 neighbors" <|
                \_ ->
                    willLive True 2
                        |> Expect.equal True
            , test "Dies with 5 neighbors" <|
                \_ ->
                    willLive True 5
                        |> Expect.equal False
            ]
        , describe "willLive with dead cell"
            [ test "Dies with less than 3 neighbors" <|
                \_ ->
                    willLive False 2
                        |> Expect.equal False
            , test "Lives with 3 neighbors" <|
                \_ ->
                    willLive False 3
                        |> Expect.equal True
            , test "Dies with more than 3 neighbors" <|
                \_ ->
                    willLive False 4
                        |> Expect.equal False
            ]
        ]
