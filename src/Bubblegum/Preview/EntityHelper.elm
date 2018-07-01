module Bubblegum.Preview.EntityHelper
    exposing
        ( findBool
        , findIntRange
        , findString
        )

{-| Basic functions for the VocabularyHelper to facilitate the retrieval of data from the configuration
-}

import Bubblegum.Entity.Attribute as Attribute
import Bubblegum.Entity.Outcome exposing (Outcome(..))
import Bubblegum.Entity.Validation as Validation


findIntRange : ( String, String ) -> List Attribute.Model -> Outcome ( Int, Int )
findIntRange keyTuple attributes =
    Attribute.findOutcomeByKeyTuple keyTuple attributes
        |> Validation.asTuple
        |> Validation.asIntTuple
        |> Validation.asIntRange


findString : String -> List Attribute.Model -> Outcome String
findString key attributes =
    Attribute.findOutcomeByKey key attributes |> Validation.asSingle


findBool : String -> List Attribute.Model -> Outcome Bool
findBool key attributes =
    findString key attributes |> Validation.asBool
