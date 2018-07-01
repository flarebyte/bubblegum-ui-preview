module WidgetCreateTests exposing (..)

{-| Unit tests for testing the view of the Widget

    **Generated** by generate-vocabulary.py
    
-}
import Test exposing (..)
import WidgetTestData exposing (..)


suite : Test
suite =
    describe "The Widget module"
        [ describe "Widget.view"
            [

                fuzz fuzzyUserLanguage "Correct settings for Language used by the user" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserLanguage value)
                    |> findComponent selectorsUserLanguage

             , fuzz fuzzyNotUserLanguage "Wrong settings for Language used by the user" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserLanguage value) 
                    |> findComponent selectorsNotUserLanguage

                , fuzz fuzzyUserRightToLeft "Correct settings for Whether the user is using right to left" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserRightToLeft value)
                    |> findComponent selectorsUserRightToLeft

             , fuzz fuzzyNotUserRightToLeft "Wrong settings for Whether the user is using right to left" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserRightToLeft value) 
                    |> findComponent selectorsNotUserRightToLeft

                , fuzz fuzzyContent "Correct settings for The content of the field" <|
                \value -> viewWidgetWithState (withStateContent value)
                    |> findComponent selectorsContent

                , fuzz fuzzyContentAppearance "Correct settings for The appearance of the field content" <|
                \value -> viewWidgetWithSettings (withSettingsContentAppearance value)
                    |> findComponent selectorsContentAppearance

              , fuzz fuzzyNotContentAppearance "Wrong settings for The appearance of the field content" <|
                \value -> viewWidgetWithSettings (withSettingsContentAppearance value)
                    |> findWarningDiv           

            ]
        ]
