module Domy.Events.EventType where

newtype EventType :: forall kind. kind -> Type
newtype EventType event = EventType String
