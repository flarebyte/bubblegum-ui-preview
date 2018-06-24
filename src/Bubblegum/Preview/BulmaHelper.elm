module Bubblegum.Preview.BulmaHelper
    exposing
        ( appendHtmlIfSuccess
        , mainBox
        )

{-| The Bulma css framework is used for styling the widget.

See <https://bulma.io/documentation/>

This helper facilitates the creation of Bulma styled html elements.

-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Bubblegum.Preview.IsoLanguage exposing (IsoLanguage(..))
import Bubblegum.Preview.VocabularyHelper exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import List
import String exposing (join)


{-| Append some html code when the outcome is successful otherwise hide a warning in the html
-}
appendHtmlIfSuccess : (a -> Html.Html msg) -> Outcome a -> List (Html.Html msg) -> List (Html.Html msg)
appendHtmlIfSuccess ifSuccess outcome htmlList =
    case outcome of
        None ->
            htmlList

        Warning warn ->
            htmlList ++ [ div [ Attributes.class "is-invisible warning" ] [ text warn ] ]

        Valid success ->
            htmlList ++ [ ifSuccess success ]


{-| Append a list of html code when the outcome is successful otherwise hide a warning in the html
-}
appendListHtmlIfSuccess : (a -> List (Html.Html msg)) -> Outcome a -> List (Html.Html msg) -> List (Html.Html msg)
appendListHtmlIfSuccess ifSuccess outcome htmlList =
    case outcome of
        None ->
            htmlList

        Warning warn ->
            htmlList ++ [ div [ Attributes.class "is-invisible warning" ] [ text warn ] ]

        Valid success ->
            htmlList ++ ifSuccess success


{-| Append a html attribute when the outcome is successful otherwise hide a warning in the html
-}
appendAttributeIfSuccess : (a -> Attribute msg) -> Outcome a -> List (Attribute msg) -> List (Attribute msg)
appendAttributeIfSuccess ifSuccess outcome attributes =
    case outcome of
        None ->
            attributes

        Warning warn ->
            attributes ++ [ attribute "data-bubblegum-warn" warn ]

        Valid success ->
            attributes ++ [ ifSuccess success ]



-- Various helpers


asClass : List String -> Attribute msg
asClass list =
    List.reverse list |> join " " |> class


asClass2 : String -> String -> Attribute msg
asClass2 a b =
    [ b, a ] |> asClass


rtlOrLtr : Bool -> String
rtlOrLtr value =
    if value then
        "rtl"
    else
        "ltr"


mainBox : Outcome String -> Outcome Bool -> List (Html msg) -> Html msg
mainBox language rtl list =
    div
        ([ class "bubblegum-preview__widget box is-marginless is-paddingless is-shadowless" ]
            |> appendAttributeIfSuccess lang language
            |> appendAttributeIfSuccess dir (rtl |> Outcome.map rtlOrLtr)
        )
        list


contentBox : List (Html msg) -> Html msg
contentBox list =
    div [ class "content" ] list


type TextPreviewType
    = Header Int String
    | BlockQuote String
    | Paragraphs String


type alias ListItem =
    { label : Outcome String
    , description : Outcome String
    }


type ListPreviewType
    = OrderedListDecimal (List ListItem)
    | OrderedListAlphabeticUpper (List ListItem)
    | OrderedListAlphabeticLower (List ListItem)
    | OrderedListRomanUpper (List ListItem)
    | OrderedListRomanLower (List ListItem)
    | BulletedList (List ListItem)


previewText : TextPreviewType -> Html msg
previewText textType =
    case textType of
        BlockQuote textContent ->
            blockquote [] [ text textContent ]

        Paragraphs textContent ->
            p [] [ text textContent ]

        Header size textContent ->
            case size of
                1 ->
                    h1 [] [ text textContent ]

                2 ->
                    h2 [] [ text textContent ]

                3 ->
                    h3 [] [ text textContent ]

                4 ->
                    h4 [] [ text textContent ]

                5 ->
                    h5 [] [ text textContent ]

                6 ->
                    h6 [] [ text textContent ]

                _ ->
                    h6 [ class "is-invisible" ] [ text textContent ]


previewTextListItem : ListItem -> Html msg
previewTextListItem listItem =
    li ([] |> appendAttributeIfSuccess title listItem.description)
        ([] |> appendHtmlIfSuccess text listItem.label)


previewTextListType : ListPreviewType -> String
previewTextListType listPreviewType =
    case listPreviewType of
        OrderedListDecimal _ ->
            "1"

        OrderedListAlphabeticUpper _ ->
            "A"

        OrderedListAlphabeticLower _ ->
            "a"

        OrderedListRomanUpper _ ->
            "I"

        OrderedListRomanLower _ ->
            "i"

        BulletedList _ ->
            "disc"


previewTextList : ListPreviewType -> Html msg
previewTextList listPreviewType =
    case listPreviewType of
        OrderedListDecimal list ->
            List.map previewTextListItem list |> ol [ type_ (previewTextListType listPreviewType) ]

        OrderedListAlphabeticUpper list ->
            List.map previewTextListItem list |> ol [ type_ (previewTextListType listPreviewType) ]

        OrderedListAlphabeticLower list ->
            List.map previewTextListItem list |> ol [ type_ (previewTextListType listPreviewType) ]

        OrderedListRomanUpper list ->
            List.map previewTextListItem list |> ol [ type_ (previewTextListType listPreviewType) ]

        OrderedListRomanLower list ->
            List.map previewTextListItem list |> ol [ type_ (previewTextListType listPreviewType) ]

        BulletedList list ->
            List.map previewTextListItem list |> ul []
