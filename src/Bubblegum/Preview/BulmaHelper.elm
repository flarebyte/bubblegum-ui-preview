module Bubblegum.Preview.BulmaHelper
    exposing
        ( ListPreviewType(..)
        , appendHtmlIfSuccess
        , contentBox
        , mainBox
        , previewText
        )

{-| The Bulma css framework is used for styling the widget.

See <https://bulma.io/documentation/>

This helper facilitates the creation of Bulma styled html elements.

-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Bubblegum.Entity.Validation as Validation
import Bubblegum.Preview.Adapter as TagAdapter
import Bubblegum.Preview.VocabularyHelper exposing (EnumContentAppearance(..))
import Html as Html
    exposing
        ( Attribute
        , Html
        , article
        , blockquote
        , code
        , div
        , h1
        , h2
        , h3
        , h4
        , h5
        , h6
        , p
        , pre
        , samp
        , text
        )
import Html.Attributes as Attributes exposing (attribute, class, dir, lang)
import Html.Events exposing (onMouseOver)
import List


{-| Append some html code when the outcome is successful otherwise hide a warning in the html
-}
appendHtmlIfSuccess : (a -> Html msg) -> Outcome a -> List (Html msg) -> List (Html msg)
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
appendListHtmlIfSuccess : (a -> List (Html msg)) -> Outcome a -> List (Html msg) -> List (Html msg)
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


rtlOrLtr : Bool -> String
rtlOrLtr value =
    if value then
        "rtl"
    else
        "ltr"


mainBox : TagAdapter.Model msg -> Outcome String -> Outcome Bool -> Outcome String -> List (Html msg) -> Html msg
mainBox adapter language rtl id list =
    let
        idOrBlank =
            Outcome.toMaybe id |> Maybe.withDefault ""
    in
    div
        ([ class "bubblegum-preview__widget box is-marginless is-paddingless is-shadowless", onMouseOver (adapter.onMouseOver idOrBlank) ]
            |> appendAttributeIfSuccess lang language
            |> appendAttributeIfSuccess dir (rtl |> Outcome.map rtlOrLtr)
            |> appendAttributeIfSuccess (attribute "data-bubblegum-id") id
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

        UiContentAppearanceDark ->
            article [ class "message is-dark" ] [ div [ class "message-body" ] (paragraphs linesOutcome) ]

        UiContentAppearancePrimary ->
            article [ class "message is-primary" ] [ div [ class "message-body" ] (paragraphs linesOutcome) ]

        UiContentAppearanceInfo ->
            article [ class "message is-info" ] [ div [ class "message-body" ] (paragraphs linesOutcome) ]

        UiContentAppearanceSuccess ->
            article [ class "message is-success" ] [ div [ class "message-body" ] (paragraphs linesOutcome) ]

        UiContentAppearanceWarning ->
            article [ class "message is-warning" ] [ div [ class "message-body" ] (paragraphs linesOutcome) ]

        UiContentAppearanceDanger ->
            article [ class "message is-danger" ] [ div [ class "message-body" ] (paragraphs linesOutcome) ]

        UiContentAppearanceHeaderOne ->
            h1 [] ([] |> appendHtmlIfSuccess text contentOutcome)

        UiContentAppearanceCode ->
            pre [] [ code [] ([] |> appendHtmlIfSuccess text contentOutcome) ]

        UiContentAppearanceSample ->
            pre [] [ samp [] ([] |> appendHtmlIfSuccess text contentOutcome) ]

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
