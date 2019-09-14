module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, h3, img, text)
import Html.Attributes exposing (src)



---- MODEL ----


type alias Model =
    { n : List Int }


init : ( Model, Cmd Msg )
init =
    ( { n = [ 8 ] }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working. This is a UI test." ]
        , h3 [] [ text "Your Elm App is working. This is a UI test." ]
        , img [ src "/logo.svg" ] []
        , h3 [] [ Maybe.withDefault 5 (List.head model.n) |> String.fromInt |> text ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
