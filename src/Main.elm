module Main exposing (ncert, ncert12, ncertm)

import Browser
import Html exposing (Html, div, h1, h3, img, input, text)
import Html.Attributes exposing (placeholder, src, type_, value)
import Html.Events exposing (onInput)



---- MODEL ----


type alias Model =
    { k : List Int
    , i : Float
    , n : Float
    , iString : String
    , nString : String
    }


init : ( Model, Cmd Msg )
init =
    ( { k = [ 8 ], iString = "0.08", i = 0.08, nString = "10", n = 10 }, Cmd.none )


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
    | InterestInput String
    | NInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        InterestInput str ->
            ( { model | iString = str, i = parseInterest str |> Maybe.withDefault model.i }, Cmd.none )

        NInput str ->
            ( { model | nString = str, n = parseInterest str |> Maybe.withDefault model.n }, Cmd.none )


parseInterest : String -> Maybe Float
parseInterest userInput =
    String.toFloat userInput
        |> Maybe.andThen toValidInterest


toValidInterest : Float -> Maybe Float
toValidInterest i =
    if i > 0 && i <= 1 then
        Just i

    else
        Nothing



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working. This is a UI test." ]
        , h3 [] [ text "Your Elm App is working. This is a UI test." ]
        , img [ src "/logo.svg" ] []
        , h3 [] [ Maybe.withDefault 5 (List.head model.k) |> String.fromInt |> text ]
        , h3 [] [ ncert model.i model.n |> String.fromFloat |> text ]
        , h3 [] [ ncertm 12 model.i model.n |> String.fromFloat |> text ]
        , input [ type_ "text", placeholder "enter interest", onInput InterestInput, value model.iString ] []
        , input [ type_ "text", placeholder "enter n", onInput NInput, value model.nString ] []
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
