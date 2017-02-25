module CoinFlip exposing (main)

import Platform.Cmd exposing (Cmd)
import Task exposing (Task)
import Html exposing (..)
import Html.Events exposing (..)

import Crypto

type alias Model =
  {
    coin : Maybe Bool,
    logs : List String
  }

type Msg = Toss | Catch Bool | Failed Crypto.Error

init : (Model, Cmd Msg)
init = ({ coin = Nothing, logs = [] }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Toss ->
      let
        resultToCmd : Result Crypto.Error Bool -> Msg
        resultToCmd result = case result of
          Ok boolean -> Catch boolean
          Err error -> Failed error

        cmd = Task.attempt resultToCmd Crypto.bool
      in (model, cmd)
    Catch coin -> ({ model | coin = Just coin }, Cmd.none)
    Failed error ->
      let
        log = case error of
          Crypto.NoGetRandomValues -> "There's no getRandomValues() function."
          Crypto.Exception _ _ -> "An exception has been occurred" -- TODO
        newLogs = log::(model.logs)
      in
      ({ model | logs = newLogs }, Cmd.none)

view : Model -> Html Msg
view model =
  let
    logs = List.map (\log -> li [] [text log]) model.logs
  in
    section [] [
      div [] (
        case model.coin of
          Nothing ->
            [
              button [ onClick Toss ] [ text "Toss a coin..." ]
            ]
          Just coin ->
            [
              button [ onClick Toss] [ text "Toss again!" ],
              p [] [ text <| if coin then "Heads!" else "Tails!" ]
            ]
      ),
      hr [] [],
      ul [] logs
    ]

main = Html.program
  {
    init = init,
    update = update,
    view = view,
    subscriptions = \_ -> Sub.none
  }
