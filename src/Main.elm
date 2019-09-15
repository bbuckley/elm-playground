module Main exposing (ncert, ncert12, ncertm)

import Browser
import Html exposing (Html, div, h1, h3, img, text)
import Html.Attributes exposing (src)



---- MODEL ----


type alias Model =
    { k : List Int }


init : ( Model, Cmd Msg )
init =
    ( { k = [ 8 ] }, Cmd.none )


v : number -> number
v i =
    (1 + i) ^ -1


d : number -> number
d i =
    i * v i


ncert : number -> number -> number
ncert i n =
    (1 - v i ^ n) * d i ^ -1


ip : number -> number -> number
ip n i =
    (1 + i) ^ (n ^ -1) - 1


ncertm : number -> number -> number -> number
ncertm m i n =
    ncert (ip m i) (m * n) * m ^ -1


ncert12 : number -> number -> number
ncert12 i n =
    ncert (ip 12 i) (12 * n) * 12 ^ -1



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
        , h3 [] [ ncert 0.08 10 |> String.fromFloat |> text ]
        , h3 [] [ ncertm 12 0.08 10 |> String.fromFloat |> text ]
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
