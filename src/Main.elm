module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.LazyExtra
import Time


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    Int


type Msg
    = Increment
    | Decrement
    | Tick


init : a -> ( Model, Cmd msg )
init _ =
    ( 0, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )

        Tick ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Html.LazyExtra.lazyShallow
        viewHelp
        { model = model
        , lazyDummy = ()
        }


viewHelp : { a | model : Int } -> Html Msg
viewHelp { model } =
    let
        _ =
            Debug.log "Rendering" model
    in
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 200 (\_ -> Tick)
