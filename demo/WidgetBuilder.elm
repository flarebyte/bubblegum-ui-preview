module WidgetBuilder exposing (viewWidget)

import AppModel exposing (AppModel)
import AppMsg exposing (AppMsg(..))
import Bubblegum.Preview.Adapter as Adapter
import Bubblegum.Preview.Widget as Widget
import Html exposing (..)


adapter : Adapter.Model AppMsg
adapter =
    { onMouseOver = OnMouseOver
    }


viewWidget : AppModel -> Html AppMsg
viewWidget model =
    Widget.view adapter model.userSettings model.settings model.state
