module Views.ApiDomainTransactions exposing (..)

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


pageApiDomainTransactions : Model -> List (Html Msg)
pageApiDomainTransactions model =
    let
        description =
            div [] [ Html.text "This retrieves the transactions for a domain as Json" ]

        ex = """{
                  "status": "success",
                  "result": [
                    {
                      "id": "d7900abe99bf8cab768b62e543cd909e5a99fa2f800186a63de546326cce1c4f",
                      "action": "head",
                      "senders": [],
                      "recipients": [
                        {
                          "address": "VDBjMTlkMWM0NTZhYmE3ZjdmYmVkMDgwMWFhZTMyMDRhMTUzNjFhYWUwYzk3ODQ5",
                          "amount": 2502
                        }
                      ],
                      "message": "0",
                      "token": "SHARI",
                      "prev_hash": "0"
                    },
                    {
                      "id": "a5ad8f71befd4713700b9a0b9402bb0370bd68b32dbf5d54afb23ada74e47483",
                      "action": "head",
                      "senders": [],
                      "recipients": [
                        {
                          "address": "VDBjMTlkMWM0NTZhYmE3ZjdmYmVkMDgwMWFhZTMyMDRhMTUzNjFhYWUwYzk3ODQ5",
                          "amount": 2501
                        }
                      ],
                      "message": "0",
                      "token": "SHARI",
                      "prev_hash": "0"
                    }
                  ]
                }"""
    in
        [ br [] []
        , Grid.row []
            [ apiLeftNav ApiDomainTransactions
            , Grid.col [ Col.md9 ]
                [ documentation ApiDomainTransactions model.apiUrlD1 Nothing model.apiResponse "Domain Transactions" description "GET" "api/v1/domain/{:domain}/transactions" (Just confirmationQueryParams) Nothing "curl -X GET -H 'Content-Type: application/json' http://testnet.sushichain.io:3000/api/v1/domain/{:domain}/transactions" ex model.error
                ]
            ]
        ]
