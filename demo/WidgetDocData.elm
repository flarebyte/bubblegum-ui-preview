module WidgetDocData exposing (tagWidgetDoc)

import AttributeDoc exposing (AttributeDoc, Cardinality(..), createKey)
import Bubblegum.Preview.Vocabulary exposing (..)
import KeyDescription exposing (..)
import WidgetDoc exposing (..)
import WidgetPackageJson


{-| Some examples of settings for the demo.

    **Generated** by generate-vocabulary.py

-}
tagWidgetDoc : WidgetDoc
tagWidgetDoc =
    { meta = WidgetPackageJson.meta
    , userSettings =
        [ createKey ui_userLanguage ZeroOrOne [ "en-GB", "ja", "ar", "zh-CN-SC", "ru-RUS", "es", "it", "fr", "other" ] descUserLanguage
        , createKey ui_userRightToLeft ZeroOrOne [ "true", "false", "other" ] descUserRightToLeft
        ]
    , settings =
        [ createKey ui_contentAppearance ZeroOrOne [ "ui:content-appearance/header/one", "ui:content-appearance/header/two", "ui:content-appearance/header/three", "ui:content-appearance/header/four", "ui:content-appearance/header/five", "ui:content-appearance/header/six", "ui:content-appearance/block-quote", "ui:content-appearance/paragraphs", "ui:content-appearance/code", "ui:content-appearance/sample", "ui:content-appearance/dark", "ui:content-appearance/primary", "ui:content-appearance/info", "ui:content-appearance/success", "ui:content-appearance/warning", "ui:content-appearance/danger" ] descContentAppearance
        ]
    , stateAttributes =
        [ createKey ui_content ZeroOrOne [ "some content", "other" ] descContent
        ]
    }
