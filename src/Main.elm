module Main exposing (ncert, ncertm)

import Browser
import Html exposing (Html, div, h1, h3, img, text)
import Html.Attributes exposing (src)



---- MODEL ----


type alias Model =
    { k : List Int }


init : ( Model, Cmd Msg )
init =
    ( { k = [ 8 ] }, Cmd.none )


ncert : Float -> Float -> Float
ncert i n =
    let
        v =
            1 / (1 + i)
    in
    (1 - v ^ n) / (i * v)


ip : Float -> Float -> Float
ip n i =
    (1 + i) ^ (1 / n) - 1


ncertm : Float -> Float -> Float -> Float
ncertm m i n =
    ncert (ip m i) (m * n) / m



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
        , h3 [] [ Maybe.withDefault 5 (List.head model.k) |> String.fromInt |> text ]
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
