module TagSuggestions exposing (getExampleAttributes)

import Bubblegum.Entity.Attribute as Attribute
import Bubblegum.Preview.Vocabulary exposing (..)
import Ipsum exposing (ipsum)


widgetId : String
widgetId =
    "id:tag:123"


attri : String -> String -> List String -> Attribute.Model
attri id key values =
    { id = Just id
    , key = key
    , facets = []
    , values = values
    }


attr : String -> List String -> Attribute.Model
attr key values =
    { id = Nothing
    , key = key
    , facets = []
    , values = values
    }


suggestion : Int -> List Attribute.Model
suggestion uid =
    let
        id =
            "id:suggestion:" ++ toString uid

        label =
            String.slice uid (2 * uid) ipsum

        description =
            ipsum |> String.reverse |> String.slice uid (3 * uid)
    in
    [ attri id ui_constituentLabel [ label ]
    , attri id ui_constituentDescription [ description ]
    ]


getExampleAttributes : List Attribute.Model
getExampleAttributes =
    suggestion 15
        ++ suggestion 1
        ++ suggestion 19
        ++ suggestion 2
        ++ suggestion 3
        ++ suggestion 7
        ++ suggestion 16
        ++ suggestion 17
        ++ suggestion 18
        ++ suggestion 8
        ++ suggestion 9
        ++ suggestion 10
        ++ suggestion 11
        ++ suggestion 12
        ++ suggestion 4
        ++ suggestion 5
        ++ suggestion 6
        ++ suggestion 13
        ++ suggestion 14
        ++ suggestion 20
