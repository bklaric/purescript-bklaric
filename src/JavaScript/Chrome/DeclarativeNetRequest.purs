module JavaScript.Chrome.DeclarativeNetRequest
    ( RequestHeaderModification
    , RuleAction
    , RuleCondition
    , Rule
    , UpdateRuleOptions
    , updateSessionRules
    , updateDynamicRules
    , UpdateRulesetOptions
    , updateEnabledRulesets
    ) where

import Prelude

import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Literals (StringLit)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|))

-- https://developer.chrome.com/docs/extensions/reference/api/declarativeNetRequest

-- | A single request-header rewrite within a `modifyHeaders` action.
type RequestHeaderModification =
    { header :: String
    , operation :: StringLit "set" |+| StringLit "remove" |+| StringLit "append"
    , value :: String
    }

-- | `type` is the action kind, e.g. "modifyHeaders".
type RuleAction =
    { "type" :: String
    , requestHeaders :: Array RequestHeaderModification
    }

type RuleCondition =
    { regexFilter :: String
    , resourceTypes :: Array String
    }

type Rule =
    { id :: Int
    , priority :: Int
    , action :: RuleAction
    , condition :: RuleCondition
    }

type UpdateRuleOptions =
    { addRules :: Array Rule
    , removeRuleIds :: Array Int
    }

foreign import _updateSessionRules :: UpdateRuleOptions -> Promise Error Unit

-- | Add and/or remove session-scoped rules. Session rules persist for the
-- | duration of the browser session (cleared on browser restart) and are not
-- | reflected in the static ruleset. Removing then re-adding the same id makes
-- | the call idempotent. Takes any record castable to `UpdateRuleOptions`, so
-- | callers can pass `stringLit` operation literals and have them lifted into
-- | the union.
updateSessionRules :: forall options. Castable options UpdateRuleOptions => options -> Promise Error Unit
updateSessionRules = _updateSessionRules <<< cast

foreign import _updateDynamicRules :: UpdateRuleOptions -> Promise Error Unit

-- | Add and/or remove dynamic rules. Unlike session rules, dynamic rules persist
-- | across browser restarts and extension updates. Same calling convention as
-- | `updateSessionRules`.
updateDynamicRules :: forall options. Castable options UpdateRuleOptions => options -> Promise Error Unit
updateDynamicRules = _updateDynamicRules <<< cast

-- | The ids of static rulesets (from the manifest's `declarative_net_request.rule_resources`)
-- | to switch on and off.
type UpdateRulesetOptions =
    { enableRulesetIds :: Array String
    , disableRulesetIds :: Array String
    }

foreign import _updateEnabledRulesets :: UpdateRulesetOptions -> Promise Error Unit

-- | Enable and/or disable static rulesets. The enabled set persists across browser sessions but
-- | not across extension updates, which reset it to the manifest's `enabled` values.
updateEnabledRulesets :: UpdateRulesetOptions -> Promise Error Unit
updateEnabledRulesets = _updateEnabledRulesets
