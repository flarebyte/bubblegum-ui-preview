module Bubblegum.Preview.BulmaHelper
    exposing
        ( ListPreviewType(..)
        , appendHtmlIfSuccess
        , contentBox
        , mainBox
        , previewText
        , previewTextList
        )

{-| The Bulma css framework is used for styling the widget.

See <https://bulma.io/documentation/>

This helper facilitates the creation of Bulma styled html elements.

-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Bubblegum.Preview.Helper exposing (ListItem, TextPreviewType(..))
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


type ListPreviewType
    = OrderedListDecimal
    | OrderedListAlphabeticUpper
    | OrderedListAlphabeticLower
    | OrderedListRomanUpper
    | OrderedListRomanLower
    | BulletedList


previewText : TextPreviewType -> Html msg
previewText textType =
    case textType of
        BlockQuote textContent ->
            blockquote [] ([] |> appendHtmlIfSuccess text textContent)

        Paragraphs textContent ->
            p [] ([] |> appendHtmlIfSuccess text textContent)

        Header size textContent ->
            case size of
                1 ->
                    h1 [] ([] |> appendHtmlIfSuccess text textContent)

                2 ->
                    h2 [] ([] |> appendHtmlIfSuccess text textContent)

                3 ->
                    h3 [] ([] |> appendHtmlIfSuccess text textContent)

                4 ->
                    h4 [] ([] |> appendHtmlIfSuccess text textContent)

                5 ->
                    h5 [] ([] |> appendHtmlIfSuccess text textContent)

                6 ->
                    h6 [] ([] |> appendHtmlIfSuccess text textContent)

                _ ->
                    h6 [ class "is-invisible" ] ([] |> appendHtmlIfSuccess text textContent)


previewTextListItem : ListItem -> Html msg
previewTextListItem listItem =
    li ([] |> appendAttributeIfSuccess title listItem.description)
        ([] |> appendHtmlIfSuccess text listItem.label)


previewTextListItems : List ListItem -> List (Html msg)
previewTextListItems list =
    List.map previewTextListItem list


previewTextListType : ListPreviewType -> String
previewTextListType listPreviewType =
    case listPreviewType of
        OrderedListDecimal ->
            "1"

        OrderedListAlphabeticUpper ->
            "A"

        OrderedListAlphabeticLower ->
            "a"

        OrderedListRomanUpper ->
            "I"

        OrderedListRomanLower ->
            "i"

        BulletedList ->
            "disc"


previewTextList : ListPreviewType -> Outcome (List ListItem) -> Html msg
previewTextList listPreviewType outcome =
    let
        liList =
            [] |> appendListHtmlIfSuccess previewTextListItems outcome
    in
    case listPreviewType of
        OrderedListDecimal ->
            liList |> ol [ type_ (previewTextListType listPreviewType) ]

        OrderedListAlphabeticUpper ->
            liList |> ol [ type_ (previewTextListType listPreviewType) ]

        OrderedListAlphabeticLower ->
            liList |> ol [ type_ (previewTextListType listPreviewType) ]

        OrderedListRomanUpper ->
            liList |> ol [ type_ (previewTextListType listPreviewType) ]

        OrderedListRomanLower ->
            liList |> ol [ type_ (previewTextListType listPreviewType) ]

        BulletedList ->
            liList |> ul []
