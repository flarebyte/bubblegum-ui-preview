module Bubblegum.Preview.Widget exposing (view)

{-| A flexible preview widget to display content:

  - Supports multiple languages as well as right to left writing.

Please have a look at the main [documentation](https://github.com/flarebyte/bubblegum-ui-preview) for more details about the possible settings.

@docs view

-}

import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Preview.Adapter as TagAdapter
import Bubblegum.Preview.BulmaHelper exposing (ListPreviewType(..), contentBox, mainBox, previewText)
import Bubblegum.Preview.VocabularyHelper exposing (getContent, getContentAppearance, getUserLanguage, isUserRightToLeft)
import Html as Html exposing (Html)


{-| View for the widget

    attr key value = { id = Nothing , key = key, facets = [], values = [value]}

    adapter =  =
        { onSearchInput = OnSearchInput
        , onToggleDropbox = OnToggleDropbox
        , onAddTag = OnAddTag
        , onDeleteTag = OnDeleteTag
        }

    userSettings = { attributes = [attr ui_userLanguage "en-US"] }
    settings = { attributes = [ attr ui_contentAppearance "ui:content-appearance/paragraphs" ] }
    state = { attributes = [ attr ui_content "My Story"] }

    view adapter userSettings settings state

-}
view : TagAdapter.Model msg -> SettingsEntity.Model -> SettingsEntity.Model -> StateEntity.Model -> Html msg
view adapter userSettings settings state =
    mainBox (getUserLanguage userSettings)
        (isUserRightToLeft userSettings)
        [ contentBox
            [ previewText (getContentAppearance settings) (getContent state)
            ]
        ]
