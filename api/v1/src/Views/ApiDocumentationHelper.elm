module Views.ApiDocumentationHelper exposing (..)

import Html.Events exposing (onClick, onInput)
import Json.PrettyPrint
import Views.TableHelper exposing (docTable)
import Views.ApiLeftNav exposing (apiLeftNav)
import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (Model)
import Bootstrap.Navbar as Navbar
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Button as Button
import Bootstrap.ListGroup as Listgroup
import Bootstrap.Modal as Modal
import Bootstrap.Table as Table
import Bootstrap.Alert as Alert
import Bootstrap.Form.Textarea as TextArea
import Bootstrap.Form.Input as Input
import Messages exposing (Method(GET, POST), Msg(..), Page(..))


documentation msg apiUrl apiBody apiResponse title description method url requestDescription responseDescription curl ex error =
    Card.config [ Card.outlineDark ]
        |> Card.headerH4 [] [ text title ]
        |> Card.block []
            [ Block.text []
                [ div []
                    [ p [] [ description ]
                    , Html.h5 [] [ Html.text "Request" ]
                    , docTable (callTableHeader []) (tBody method url)
                    , case requestDescription of
                        Just requestDesc ->
                            requestDesc

                        _ ->
                            text ""
                    , Html.h6 [] [ Html.text "Example" ]
                    , Alert.simplePrimary [] [ Html.text curl ]
                    , hr [] []
                    , Html.h5 [] [ Html.text "Response" ]
                    , TextArea.textarea
                        [ TextArea.id "example-response"
                        , TextArea.rows 12
                        , TextArea.value <| Json.PrettyPrint.stringify ex
                        , TextArea.disabled
                        ]
                    , case responseDescription of
                        Just responseDesc ->
                            responseDesc

                        _ ->
                            text ""
                    , hr [] []
                    , Html.h5 [] [ Html.text "Try me" ]
                    , Alert.simplePrimary []
                        [ div []
                            [ Input.text [ Input.value apiUrl, Input.attrs [ onInput (SetApiUrl msg) ] ]
                            , br [] []
                            , if (msg == ApiTransactionCreate || msg == ApiTransactionCreateUnsigned) then
                                div []
                                    [ TextArea.textarea
                                        [ TextArea.id "request_body"
                                        , TextArea.rows 12
                                        , TextArea.attrs [ onInput SetApiBody ]
                                        , TextArea.value (Maybe.withDefault "" apiBody)
                                        ]
                                    , Button.button [ Button.primary, Button.attrs [ onClick (RunApiCall POST apiUrl apiBody) ] ] [ text "Run" ]
                                    ]
                              else
                                Button.button [ Button.primary, Button.attrs [ onClick (RunApiCall GET apiUrl Nothing) ] ] [ text "Run" ]
                            , if error /= "" then
                                div [] [ hr [] [], Alert.simpleDanger [] [ text error ] ]
                              else
                                text ""
                            , if apiResponse /= "" then
                                div []
                                    [ hr [] []
                                    , TextArea.textarea
                                        [ TextArea.id "response"
                                        , TextArea.rows 12

                                        --                                        , TextArea.value apiResponse
                                        , TextArea.value <| Json.PrettyPrint.stringify apiResponse
                                        ]
                                    ]
                              else
                                text ""
                            ]
                        ]
                    ]
                ]
            ]
        |> Card.view


callTableHeader : List (Table.TableHeadOption msg) -> Table.THead msg
callTableHeader options =
    Table.thead options
        [ Table.tr []
            [ Table.th [] [ Html.text "Method" ]
            , Table.th [] [ Html.text "Url" ]
            ]
        ]


tBody req url =
    (Table.tbody []
        [ Table.tr []
            [ Table.td [] [ Html.text req ]
            , Table.td [] [ Html.text url ]
            ]
        ]
    )
