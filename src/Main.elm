module Main exposing (ncert, ncert12, ncertm)

import Browser
import Html exposing (Html, div, h1, h3, img, input, text)
import Html.Attributes exposing (placeholder, src, type_)
import Html.Events exposing (onInput)



---- MODEL ----


type alias Model =
    { k : List Int
    , i : ( String, Float )
    , n : ( String, Float )
    }


init : ( Model, Cmd Msg )
init =
    ( { k = [ 8 ], i = ( "0.08", 0.08 ), n = ( "10", 10 ) }, Cmd.none )


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
            let
                ( oldString, oldValue ) =
                    model.i

                -- f =
                --     Maybe.withDefault oldValue (String.toFloat str)
                -- ff =
                --     if f > 0 && f <= 1 then
                --         f
                --     else
                --         oldValue
            in
            ( { model | i = ( str, Maybe.withDefault oldValue (parseInterest str) ) }, Cmd.none )

        NInput str ->
            let
                ( oldString, oldValue ) =
                    model.n

                -- f =
                --     Maybe.withDefault oldValue (String.toFloat str)
                -- ff =
                --     if f >= 0 && f <= 100 then
                --         f
                --     else
                --         oldValue
                -- fff =
                --     Maybe.withDefault oldValue (parseInterest str)
            in
            ( { model | n = ( str, Maybe.withDefault oldValue (parseInterest str) ) }, Cmd.none )


parseInterest : String -> Maybe Float
parseInterest userInput =
    String.toFloat userInput
        |> Maybe.andThen toValidInterest


toValidInterest : Float -> Maybe Float
toValidInterest i =
    if 0 > i && i <= 1 then
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
        , h3 [] [ ncert (Tuple.second model.i) (Tuple.second model.n) |> String.fromFloat |> text ]
        , h3 [] [ ncertm 12 (Tuple.second model.i) (Tuple.second model.n) |> String.fromFloat |> text ]
        , input [ type_ "text", placeholder "enter interest", onInput InterestInput ] []
        , input [ type_ "text", placeholder "enter n", onInput NInput ] []
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
