module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, hr, p, text)
import Html.Attributes exposing (id, style)
import Html.Events exposing (onClick)
import Random



---- MODEL ----


type alias Model =
    { list : List Float
    , new : Maybe Float
    }


init : ( Model, Cmd Msg )
init =
    ( Model [] Nothing, Cmd.none )



---- UPDATE ----


type Msg
    = AddRandomNumber
    | Roll Float
    | DelRandomNumber Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DelRandomNumber f ->
            ( { model
                | list = model.list |> List.filter ((/=) f)
                , new =
                    if List.all ((/=) f) model.list then
                        -- model.new
                        Nothing

                    else
                        Nothing
              }
            , Cmd.none
            )

        AddRandomNumber ->
            ( model, Random.generate Roll (Random.float 1.8 2) )

        Roll float ->
            ( { model
                | list = float :: model.list
                , new = Just float
              }
            , Cmd.none
            )



---- VIEW ----


s : List (Html.Attribute Msg)
s =
    [ style "cursor" "pointer", style "border" "solid" ]


shouldBeMarkedNew : Float -> Maybe Float -> Bool
shouldBeMarkedNew fl mf =
    case mf of
        Nothing ->
            False

        Just f ->
            fl == f


mark_id : Model -> List (Html Msg)



-- mark_id : Model -> List (Float, Bool)
-- mark_id : Model -> List (List (Html.Attribute Msg))


mark_id model =
    List.map
        (\f ->
            if shouldBeMarkedNew f model.new then
                -- (f, True)
                p (id "new" :: (onClick (DelRandomNumber f) :: s)) [ String.fromFloat f |> text ]

            else
                -- (f, False)
                p (onClick (DelRandomNumber f) :: s) [ String.fromFloat f |> text ]
        )
        model.list


view : Model -> Html Msg
view model =
    div []
        [ h1 [ onClick AddRandomNumber, style "cursor" "pointer" ] [ text "Your Elm App is working - click to add rand" ]
        , hr [] []
        , div []
            (mark_id model)
        ]



-- pp f model =
--   case model.new of
--      Just fl -> (onClick (DelRandomNumber fl) :: s)
--      Nothing -> (onClick (DelRandomNumber f) :: s)
---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
