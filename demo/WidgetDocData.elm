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
        [ createKey ui_contentLanguage ZeroOrOne [ "en-GB", "ja", "ar", "zh-CN-SC", "ru-RUS", "es", "it", "fr", "other" ] descContentLanguage
        , createKey ui_contentRightToLeft ZeroOrOne [ "true", "false", "other" ] descContentRightToLeft
        , createKey ui_userLanguage ZeroOrOne [ "en-GB", "ja", "ar", "zh-CN-SC", "ru-RUS", "es", "it", "fr", "other" ] descUserLanguage
        , createKey ui_userRightToLeft ZeroOrOne [ "true", "false", "other" ] descUserRightToLeft
        ]
    , settings =
        [ createKey ui_contentAppearance ZeroOrOne [ "ui:content-appearance/header/one", "ui:content-appearance/header/two", "ui:content-appearance/header/three", "ui:content-appearance/header/four", "ui:content-appearance/header/five", "ui:content-appearance/header/six", "ui:content-appearance/block-quote", "ui:content-appearance/paragraphs" ] descContentAppearance
        ]
    , stateAttributes =
        [ createKey ui_content ZeroOrOne [ "some content", "other" ] descContent
        , createKey ui_selected ZeroOrOne [ "id:suggestion:1", "other" ] descSelected
        ]
    }
