module AppMsg exposing (AppMsg(..))


type AppMsg
    = OnSelectSetting Bool String String
    | OnSelectState String String
    | OnActivateSetting Bool String
    | OnActivateState String
    | OnMouseOver String
