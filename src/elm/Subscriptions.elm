module Subscriptions exposing (..)

import Model exposing (Model, wrap)
import Time exposing (millisecond)
import Update exposing (Msg(..))


subscriptions : Model -> Sub Msg
subscriptions ({ running } as model) =
    if running then
        Time.every (100 * millisecond) (\_ -> Tick)
    else
        Sub.none
