module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, h3, img, input, text)
import Html.Attributes exposing (placeholder, src, type_, value)
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


type Msg
    = NumeratorInput String
    | DenominatorInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NumeratorInput s ->
            ( { model
                | numeratorString = s
                , numerator = Maybe.withDefault model.numerator (String.toFloat s)
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
        [ h1 [] [ text ("numeratorString is " ++ model.numeratorString) ]
        , h1 [] [ text ("denominatorString is " ++ model.denominatorString) ]
        , h1 [] [ text ("numerator is " ++ String.fromFloat model.numerator) ]
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
