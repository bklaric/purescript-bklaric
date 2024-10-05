module JavaScript.Chrome.Management.ExtensionInstallType where

import Data.Maybe (Maybe(..))

data ExtensionInstallType = Admin | Development | Normal | Sideload | Other

fromString :: String -> Maybe ExtensionInstallType
fromString "admin" = Just Admin
fromString "development" = Just Development
fromString "normal" = Just Normal
fromString "sideload" = Just Sideload
fromString "other" = Just Other
fromString _ = Nothing
