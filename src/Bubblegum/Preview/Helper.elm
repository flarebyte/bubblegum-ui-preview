module Bubblegum.Preview.Helper
    exposing
        ( getSelectedAsList
        , getUserIsoLanguage
        )

{-| Helper to keep the noise away from Widget
-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Preview.IsoLanguage exposing (IsoLanguage(..), toIsoLanguage)
import Bubblegum.Preview.VocabularyHelper
    exposing
        ( getSelected
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


getSelectedAsList : StateEntity.Model -> List String
getSelectedAsList state =
    getSelected state |> Outcome.toMaybe |> Maybe.withDefault []
