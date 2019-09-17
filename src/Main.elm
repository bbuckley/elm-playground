module Main exposing (..)

import Browser
import Color exposing (Color, red)
import Html exposing (Html, div, h1, h3, img, input, span, text)
import Html.Attributes exposing (placeholder, src, style, type_, value)
import Html.Events exposing (onInput)



---- MODEL ----


type alias Model =
    { numeratorString : String
    , denominatorString : String
    , numerator : Float
    , denominator : Float
    }


init : ( Model, Cmd Msg )
init =
    ( { numeratorString = "1"
      , denominatorString = "2"
      , numerator = 1
      , denominator = 2
      }
    , Cmd.none
    )



---- UPDATE ----


parseInterest : String -> Maybe Float
parseInterest userInput =
    String.toFloat userInput
        |> Maybe.andThen toValidInterest


toValidInterest : Float -> Maybe Float
toValidInterest i =
    if i >= 0 && i <= 1 then
        Just i

    else
        Nothing


type Msg
    = NumeratorInput String
    | DenominatorInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NumeratorInput s ->
            ( { model
                | numeratorString = s
                , numerator = parseInterest s |> Maybe.withDefault model.numerator
              }
            , Cmd.none
            )

        DenominatorInput s ->
            ( { model
                | denominatorString = s
                , denominator = Maybe.withDefault model.denominator (String.toFloat s)
              }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "numeratorString is ", span [ style "color" "red" ] [ text model.numeratorString ] ]
        , h1 [] [ text ("numerator is " ++ String.fromFloat model.numerator) ]
        , h1 [] [ text ("denominatorString is " ++ model.denominatorString) ]
        , h1 [] [ text ("denominator is " ++ String.fromFloat model.denominator) ]
        , h1 [] [ text ("numerator / denominator is " ++ String.fromFloat (model.numerator / model.denominator)) ]
        , h3 [] [ input [ type_ "text", placeholder "enter numerator", value model.numeratorString, onInput NumeratorInput ] [] ]
        , h3 [] [ input [ type_ "text", placeholder "enter denominator", value model.denominatorString, onInput DenominatorInput ] [] ]
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
