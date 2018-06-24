module Bubblegum.Preview.Widget exposing (view)

{-| A flexible listbox widget to select multiple tags with the following features:

  - Supports multiple languages as well as right to left writing.
  - You can define targets in term of number of tags and display the progress against them.
  - You can add various tags to each choice (ex: warning tag)

Please have a look at the main [documentation](https://github.com/flarebyte/bubblegum-ui-tag) for more details about the possible settings.

@docs view

-}

import Bubblegum.Entity.Outcome exposing (Outcome(..))
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Preview.Adapter as TagAdapter
import Bubblegum.Preview.BulmaHelper exposing (mainBox)
import Bubblegum.Preview.VocabularyHelper exposing (..)
import Html exposing (..)


{-| View for the widget

    attr key value = { id = Nothing , key = key, facets = [], values = [value]}

    adapter =  =
        { onSearchInput = OnSearchInput
        , onToggleDropbox = OnToggleDropbox
        , onAddTag = OnAddTag
        , onDeleteTag = OnDeleteTag
        }

    userSettings = { attributes = [attr ui_userLanguage "en-US"] }
    settings = { attributes = [attr ui_label "My Story"] ++ getExampleAttributes }
    state = { attributes = [ attr ui_suggesting "true" , attrs ui_selected [ "id:suggestion:1", "id:suggestion:3" ]] }

    view adapter userSettings settings state

-}
view : TagAdapter.Model msg -> SettingsEntity.Model -> SettingsEntity.Model -> StateEntity.Model -> Html msg
view adapter userSettings settings state =
    let
        addContent =
            getContent state

        addListContent =
            getListContent settings state
    in
    mainBox (getUserLanguage userSettings)
        (isUserRightToLeft userSettings)
        []
