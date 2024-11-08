module JavaScript.Chrome.Menus (ContextType, PropertiesRow, CreateProperties, UpdateProperties, create, update, remove, removeAll) where

import Prelude

import JavaScript.Error (Error)
import Literals (StringLit)
import JavaScript.Promise (Promise)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|), UndefinedOr)

type ContextType
    =   StringLit "all"
    |+| StringLit "action"
    |+| StringLit "audio"
    |+| StringLit "bookmark"
    |+| StringLit "browser_action"
    |+| StringLit "editable"
    |+| StringLit "frame"
    |+| StringLit "image"
    |+| StringLit "launcher"
    |+| StringLit "link"
    |+| StringLit "page"
    |+| StringLit "page_action"
    |+| StringLit "password"
    |+| StringLit "selection"
    |+| StringLit "tab"
    |+| StringLit "tools_menu"
    |+| StringLit "video"

type PropertiesRow =
    ( contexts :: UndefinedOr (Array ContextType)
    , title :: UndefinedOr String
    , visible :: UndefinedOr Boolean
    )

type CreateProperties = {id :: UndefinedOr String | PropertiesRow}

type UpdateProperties = {| PropertiesRow}

foreign import _create :: CreateProperties -> Promise Error (String |+| Int)

foreign import _update :: String |+| Int -> UpdateProperties -> Promise Error Unit

create :: forall properties
    .  Castable properties CreateProperties
    => properties -> Promise Error (String |+| Int)
create properties = _create (cast properties)

update :: forall id properties
    .  Castable id (String |+| Int)
    => Castable properties UpdateProperties
    => id -> properties -> Promise Error Unit
update id properties = _update (cast id) (cast properties)

foreign import _remove :: String |+| Int -> Promise Error Unit

remove :: forall id. Castable id (String |+| Int) => id -> Promise Error Unit
remove id = _remove (cast id)

foreign import removeAll :: Promise Error Unit
