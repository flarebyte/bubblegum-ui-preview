module WidgetTestData exposing (..)

{-| Tests data to be used by the unit tests which are themselves generated automatically.
-}

import Bubblegum.Entity.Attribute as Attribute
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Preview.Adapter as Adapter
import Bubblegum.Preview.Vocabulary exposing (..)
import Bubblegum.Preview.Widget as Widget
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, constant, int, intRange, list, string)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector)


type TestMsg
    = OnMouseOver String

biggerThanSmall : Int
biggerThanSmall =
    50


biggerThanMedium : Int
biggerThanMedium =
    200


biggerThanVeryLarge : Int
biggerThanVeryLarge =
    200000


defaultAdapter : Adapter.Model TestMsg
defaultAdapter =
    { onMouseOver = OnMouseOver
    }


defaultUserSettings : SettingsEntity.Model
defaultUserSettings =
    { attributes =
        [ attr ui_userLanguage "es-ES"
        ]
    }


defaultSettings : SettingsEntity.Model
defaultSettings =
    { attributes =
        []
    }


defaultState : StateEntity.Model
defaultState =
    { attributes =
        [
        ]
    }


viewWidgetWithSettings : SettingsEntity.Model -> Html.Html TestMsg
viewWidgetWithSettings settings =
    Widget.view defaultAdapter defaultUserSettings settings defaultState


viewWidgetWithUserSettings : SettingsEntity.Model -> Html.Html TestMsg
viewWidgetWithUserSettings userSettings =
    div []
        [ Widget.view defaultAdapter userSettings defaultSettings defaultState
        ]


viewWidgetWithState : StateEntity.Model -> Html.Html TestMsg
viewWidgetWithState state =
    div []
        [ Widget.view defaultAdapter defaultUserSettings defaultSettings state
        ]


findComponent : List Selector -> Html.Html TestMsg -> Expectation
findComponent selectors html =
    html |> Query.fromHtml |> Query.findAll selectors |> Query.count (Expect.equal 1)


findWarningDiv : Html.Html TestMsg -> Expectation
findWarningDiv html =
    html |> Query.fromHtml |> Query.findAll [ Selector.class "warning" ] |> Query.count (Expect.atLeast 1)

-- Language used by the user


createLanguageOrRandom : Int -> String
createLanguageOrRandom number =
    if number == 1 then
        "es"
    else
        createString number


withUserSettingsUserLanguage : Int -> SettingsEntity.Model
withUserSettingsUserLanguage value =
    { attributes =
        [ attr ui_userLanguage (createLanguageOrRandom value)
        ]
    }


fuzzyUserLanguage : Fuzzer Int
fuzzyUserLanguage =
    intRange 1 1


fuzzyNotUserLanguage : Fuzzer Int
fuzzyNotUserLanguage =
    intRange 50 1000


selectorsUserLanguage : List Selector
selectorsUserLanguage =
    [ Selector.class "bubblegum-preview__widget", Selector.attribute (Attributes.lang "es") ]


selectorsNotUserLanguage : List Selector
selectorsNotUserLanguage =
    [ Selector.class "bubblegum-preview__widget"
    , Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:within-string-chars-range:(1,32)")
    ]


-- Whether the user is using right to left

createTrueOrRandom : Int -> String
createTrueOrRandom number =
    if number == 1 then
        "true"
    else
        createString number


withUserSettingsUserRightToLeft : Int -> SettingsEntity.Model
withUserSettingsUserRightToLeft value =
    { attributes =
        [ attr ui_userRightToLeft (createTrueOrRandom value)
        ]
    }


fuzzyUserRightToLeft : Fuzzer Int
fuzzyUserRightToLeft =
    intRange 1 1


fuzzyNotUserRightToLeft : Fuzzer Int
fuzzyNotUserRightToLeft =
    intRange 3 1000


selectorsUserRightToLeft : List Selector
selectorsUserRightToLeft =
    [ Selector.class "bubblegum-preview__widget", Selector.attribute (Attributes.dir "rtl") ]


selectorsNotUserRightToLeft : List Selector
selectorsNotUserRightToLeft =
    [ Selector.class "bubblegum-preview__widget"
    , Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:bool")
    ]

-- The appearance of the field content
withSettingsContentAppearance: String -> SettingsEntity.Model
withSettingsContentAppearance value = {
    attributes = [
        attr ui_contentAppearance "ui:content-appearance/header/one"
    ]
 }

fuzzyContentAppearance : Fuzzer String
fuzzyContentAppearance = constant "ui:content-appearance/header/one"

fuzzyNotContentAppearance : Fuzzer String
fuzzyNotContentAppearance = string

selectorsContentAppearance : List Selector
selectorsContentAppearance = [ Selector.tag "h1"]

-- The content of the field
withStateContent: Int -> StateEntity.Model
withStateContent value = {
    attributes = [
        attr ui_content (createString value)
    ]
 }

fuzzyContent : Fuzzer Int
fuzzyContent = intRange 1 1

selectorsContent : List Selector
selectorsContent = [ Selector.class "bubblegum-preview__widget", Selector.attribute (Attributes.lang "es-ES") ]

-- private


attr : String -> String -> Attribute.Model
attr key value =
    { id = Nothing
    , key = key
    , facets = []
    , values = [ value ]
    }


attrs : String -> List String -> Attribute.Model
attrs key values =
    { id = Nothing
    , key = key
    , facets = []
    , values = values
    }


ipsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer mauris dolor, suscipit at nulla a, molestie scelerisque lectus. Nullam quis leo a felis auctor mollis ac vel turpis. Praesent eleifend ut sem et hendrerit. Vivamus sagittis tortor ipsum, eu suscipit lectus accumsan a. Vivamus elit ante, ornare vitae sem at, ornare eleifend nibh. Mauris venenatis nunc sit amet leo aliquam, in ornare quam vehicula. Morbi consequat ante sed felis semper egestas. Donec efficitur suscipit ipsum vitae ultrices. Quisque eget vehicula odio. Aliquam vitae posuere mauris. Nulla ac pulvinar felis. Integer odio libero, vulputate in erat in, tristique cursus erat."


createString : Int -> String
createString size =
    if size > 500 then
        String.repeat size "A"
    else
        String.left size ipsum
