module Bubblegum.Preview.Adapter exposing (Model)

{-| Adapter which converts event handlers for the preview widget
-}


{-| Hook into the onMouseOver event
See <https://www.w3schools.com/jsref/event_onmouseover.asp>

    { onMouseOver = OnMouseOver}

-}
type alias Model msg =
    { onMouseOver : String -> msg
    }
