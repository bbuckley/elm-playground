module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, hr, p, text)
import Html.Events exposing (onClick)
import Random



---- MODEL ----


type alias Model =
    List Float


init : ( Model, Cmd Msg )
init =
    ( [], Cmd.none )



---- UPDATE ----


type Msg
    = AddRandomNumber
    | Roll Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddRandomNumber ->
            ( model, Random.generate Roll (Random.float 0 2) )

        Roll float ->
            ( float :: model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [ onClick AddRandomNumber ] [ text "Your Elm App is working - click to add rand" ]
        , hr [] []
        , div []
            [ div [] (List.map (\f -> p [] [ String.fromFloat f |> text ]) model)
            ]
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
