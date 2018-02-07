module Main exposing (main)

import Html exposing (Html)
import Model exposing (Model, init)
import Subscriptions exposing (subscriptions)
import Update exposing (Msg, update)
import View exposing (view)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
