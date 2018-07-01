module Bubblegum.Preview.Helper
    exposing
        ( getUserIsoLanguage
        )

{-| Helper to keep the noise away from Widget
-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Preview.IsoLanguage exposing (IsoLanguage(..), toIsoLanguage)
import Bubblegum.Preview.VocabularyHelper
    exposing
        ( getUserLanguage
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
