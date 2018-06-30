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
import Bubblegum.Entity.Validation as Validation
import Bubblegum.Preview.Helper exposing (ListItem)
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


getWarningMessage : Outcome a -> String
getWarningMessage outcome =
    case outcome of
        Warning msg ->
            msg

        _ ->
            ""


paragraph : String -> Html.Html msg
paragraph someText =
    p [] [ text someText ]


paragraphs : Outcome (List String) -> List (Html.Html msg)
paragraphs outcome =
    [] |> appendListHtmlIfSuccess (\strings -> List.map paragraph strings) outcome


previewText : Outcome EnumContentAppearance -> Outcome String -> Html msg
previewText outcomeTextType contentOutcome =
    let
        textType =
            outcomeTextType |> Outcome.toMaybe |> Maybe.withDefault UnknownContentAppearance

        linesOutcome =
            Outcome.map String.lines contentOutcome

        isSingleLine =
            Validation.listEqual 1 linesOutcome |> Outcome.isValid
    in
    case textType of
        UiContentAppearanceBlockQuote ->
            if isSingleLine then
                blockquote [] ([] |> appendHtmlIfSuccess text contentOutcome)
            else
                blockquote [] (paragraphs linesOutcome)

        UiContentAppearanceParagraphs ->
            if isSingleLine then
                p [] ([] |> appendHtmlIfSuccess text contentOutcome)
            else
                div [] (paragraphs linesOutcome)

        UiContentAppearanceHeaderOne ->
            h1 [] ([] |> appendHtmlIfSuccess text contentOutcome)

        UiContentAppearanceHeaderTwo ->
            h2 [] ([] |> appendHtmlIfSuccess text contentOutcome)

        UiContentAppearanceHeaderThree ->
            h3 [] ([] |> appendHtmlIfSuccess text contentOutcome)

        UiContentAppearanceHeaderFour ->
            h4 [] ([] |> appendHtmlIfSuccess text contentOutcome)

        UiContentAppearanceHeaderFive ->
            h5 [] ([] |> appendHtmlIfSuccess text contentOutcome)

        UiContentAppearanceHeaderSix ->
            h6 [] ([] |> appendHtmlIfSuccess text contentOutcome)

        UnknownContentAppearance ->
            h6 [ class "is-invisible warning" ] [ text (getWarningMessage outcomeTextType) ]


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
