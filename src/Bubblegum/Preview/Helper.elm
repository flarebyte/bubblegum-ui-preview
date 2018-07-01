module Bubblegum.Preview.Helper
    exposing
        ( ListItem
        , getUserIsoLanguage
        )

{-| Helper to keep the noise away from Widget
-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Preview.IsoLanguage exposing (IsoLanguage(..), toIsoLanguage)
import Bubblegum.Preview.VocabularyHelper
    exposing
        ( getConstituentDescription
        , getConstituentLabel
        , getContent
        , getUserLanguage
        )
import Maybe exposing (Maybe(..))


getUserLanguageOrEnglish : SettingsEntity.Model -> String
getUserLanguageOrEnglish settings =
    getUserLanguage settings
        |> Outcome.toMaybe
        |> Maybe.withDefault "en-GB"


getUserIsoLanguage : SettingsEntity.Model -> IsoLanguage
getUserIsoLanguage settings =
    getUserLanguageOrEnglish settings |> toIsoLanguage


type alias ListItem =
    { label : Outcome String
    , description : Outcome String
    }


getListItem : SettingsEntity.Model -> String -> ListItem
getListItem settings id =
    { label = getConstituentLabel settings id
    , description = getConstituentDescription settings id
    }


getListItems : SettingsEntity.Model -> List String -> List ListItem
getListItems settings ids =
    List.map (getListItem settings) ids
