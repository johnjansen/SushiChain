module Views.ApiScarsDomain exposing (..)

import Html.Events exposing (onClick, onInput)
import Json.PrettyPrint
import Views.ApiAddressAmount exposing (confirmationQueryParams)
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
import Messages exposing (Method(GET), Msg(..), Page(..))
import Views.ApiDocumentationHelper exposing (documentation)


pageApiScarsDomain : Model -> List (Html Msg)
pageApiScarsDomain model =
    let
        description =
            div [] [ Html.text "This retrieves the status of the scars domain as Json" ]

        ex = """{"status":"success","result":{"confirmation":1,"resolved":false,"domain":{"domain_name":"sushichain.sc","address":"","status":-1,"price":0}}}"""
    in
        [ br [] []
        , Grid.row []
            [ apiLeftNav ApiScarsDomain
            , Grid.col [ Col.md9 ]
                [ documentation ApiScarsDomain model.apiUrlS2 Nothing model.apiResponse "Address Status" description "GET" "api/v1/scars/{:domain}" (Just confirmationQueryParams) Nothing "curl -X GET -H 'Content-Type: application/json' http://testnet.sushichain.io:3000/api/v1/scars/{:domain}" ex model.error
                ]
            ]
        ]
