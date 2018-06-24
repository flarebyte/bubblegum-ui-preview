module Bubblegum.Preview.VocabularyHelper exposing (..)

{-| Helpers for accessing settings

    **Generated** by generate-vocabulary.py

-}

import Bubblegum.Entity.Outcome as Outcome exposing (..)
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Entity.Validation as Validation
import Bubblegum.Preview.EntityHelper exposing (..)
import Bubblegum.Preview.HelperLimits exposing (..)
import Bubblegum.Preview.Vocabulary exposing (..)


{-| Language of the content
-}
getContentLanguage : SettingsEntity.Model -> Outcome String
getContentLanguage settings =
    findString ui_contentLanguage settings.attributes
        |> Validation.withinStringCharsRange limitSmallRangeNotEmpty


{-| Whether the content requires right to left
-}
isContentRightToLeft : SettingsEntity.Model -> Outcome Bool
isContentRightToLeft settings =
    findBool ui_contentRightToLeft settings.attributes


{-| Language used by the user
-}
getUserLanguage : SettingsEntity.Model -> Outcome String
getUserLanguage settings =
    findString ui_userLanguage settings.attributes
        |> Validation.withinStringCharsRange limitSmallRangeNotEmpty


{-| Whether the user is using right to left
-}
isUserRightToLeft : SettingsEntity.Model -> Outcome Bool
isUserRightToLeft settings =
    findBool ui_userRightToLeft settings.attributes


{-| The content of the field
-}
getContent : StateEntity.Model -> Outcome String
getContent settings =
    findString ui_content settings.attributes
        |> Validation.withinStringCharsRange limitVeryLargeRange


enumContentAppearance : List String
enumContentAppearance =
    [ "ui:content-appearance/header/one"
    , "ui:content-appearance/header/two"
    , "ui:content-appearance/header/three"
    , "ui:content-appearance/header/four"
    , "ui:content-appearance/header/five"
    , "ui:content-appearance/header/six"
    , "ui:content-appearance/block-quote"
    , "ui:content-appearance/paragraphs"
    ]


type EnumContentAppearance
    = UiContentAppearanceHeaderOne
    | UiContentAppearanceHeaderTwo
    | UiContentAppearanceHeaderThree
    | UiContentAppearanceHeaderFour
    | UiContentAppearanceHeaderFive
    | UiContentAppearanceHeaderSix
    | UiContentAppearanceBlockQuote
    | UiContentAppearanceParagraphs


stringToEnumContentAppearance : String -> EnumContentAppearance
stringToEnumContentAppearance value =
    case value of
        "ui:content-appearance/header/one" ->
            UiContentAppearanceHeaderOne

        _ ->
            UiContentAppearanceParagraphs


{-| The appearance of the field content
-}
getContentAppearance : SettingsEntity.Model -> Outcome String
getContentAppearance settings =
    findString ui_contentAppearance settings.attributes
        |> Validation.matchEnum enumContentAppearance


{-| The selected tags for the field
-}
getSelected : StateEntity.Model -> Outcome (List String)
getSelected settings =
    findListCompactUri ui_selected settings.attributes


{-| Label of the constituent
-}
getConstituentLabel : SettingsEntity.Model -> String -> Outcome String
getConstituentLabel settings id =
    findStringForId ui_constituentLabel settings.attributes id
        |> Validation.withinStringCharsRange limitMediumRangeNotEmpty


{-| Description of the constituent
-}
getConstituentDescription : SettingsEntity.Model -> String -> Outcome String
getConstituentDescription settings id =
    findStringForId ui_constituentDescription settings.attributes id
        |> Validation.withinStringCharsRange limitMediumRangeNotEmpty
