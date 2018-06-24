module Bubblegum.Preview.Vocabulary exposing (..)

{-| List of keys used for the settings

    **Generated** by generate-vocabulary.py

-}


{-| Language of the content. (String)
-}
ui_contentLanguage : String
ui_contentLanguage =
    "ui:content-language"


{-| Whether the content requires right to left. (Bool)
-}
ui_contentRightToLeft : String
ui_contentRightToLeft =
    "ui:content-right-to-left"


{-| Language used by the user. (String)
-}
ui_userLanguage : String
ui_userLanguage =
    "ui:user-language"


{-| Whether the user is using right to left. (Bool)
-}
ui_userRightToLeft : String
ui_userRightToLeft =
    "ui:user-right-to-left"


{-| The content of the field. (String)
-}
ui_content : String
ui_content =
    "ui:content"


{-| The selected tags for the field. (List String)
-}
ui_selected : String
ui_selected =
    "ui:selected"


{-| Label of the constituent. (String)
-}
ui_constituentLabel : String
ui_constituentLabel =
    "ui:constituent-label"


{-| Description of the constituent. (String)
-}
ui_constituentDescription : String
ui_constituentDescription =
    "ui:constituent-description"


{-| Tag used to describe the constituent. (List String)
-}
ui_constituentTag : String
ui_constituentTag =
    "ui:constituent-tag"


{-| Tag representing a warning aspect of the constituent. (List String)
-}
ui_constituentWarningTag : String
ui_constituentWarningTag =
    "ui:constituent-warning-tag"


{-| Tag representing a dangerous aspect of the constituent. (List String)
-}
ui_constituentDangerTag : String
ui_constituentDangerTag =
    "ui:constituent-danger-tag"
