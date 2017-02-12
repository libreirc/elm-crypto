module CoinFlip exposing (main)

import Platform.Cmd exposing (Cmd)
import Task exposing (Task)
import Html.App as App
import Html exposing (..)
import Html.Events exposing (..)

import Random.Secure

type alias Model = { coin : Maybe Bool }

type Msg = Toss | Catch Bool | Failed

init : (Model, Cmd Msg)
init = ({ coin = Nothing }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Toss ->
      let
        errorToMsg = \_ -> Failed
        contentToMsg = \value -> Catch value
        cmd = Task.perform errorToMsg contentToMsg Random.Secure.bool
      in (model, cmd)
    Catch coin -> ({ model | coin = Just coin }, Cmd.none)
    Failed ->
      -- TODO: Error Handling
      (model, Cmd.none)

view : Model -> Html Msg
view model =
  div [] <|
    case model.coin of
      Nothing ->
        [
          button [ onClick Toss ] [ text "Toss a coin..." ]
        ]
      Just coin ->
        [
          p [] [ text <| if coin then "Heads!" else "Tails!" ],
          button [ onClick Toss] [ text "Toss again!" ]
        ]

main = App.program
  {
    init = init,
    update = update,
    view = view,
    subscriptions = \_ -> Sub.none
  }
