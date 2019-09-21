module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, hr, p, text)
import Html.Attributes exposing (style)
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
    | DelRandomNumber Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DelRandomNumber f ->
            ( model |> List.filter ((/=) f), Cmd.none )

        AddRandomNumber ->
            ( model, Random.generate Roll (Random.float 1.8 2) )

        Roll float ->
            ( float :: model, Cmd.none )



---- VIEW ----


s : List (Html.Attribute Msg)
s =
    [ style "cursor" "pointer", style "border" "solid" ]


view : Model -> Html Msg
view model =
    div []
        [ h1 [ onClick AddRandomNumber, style "cursor" "pointer" ] [ text "Your Elm App is working - click to add rand" ]
        , hr [] []
        , div [] (List.map (\f -> p (onClick (DelRandomNumber f) :: s) [ String.fromFloat f |> text ]) model)
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
