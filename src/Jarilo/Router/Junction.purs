module Jarilo.Router.Junction where

import Data.Symbol (class IsSymbol)
import Jarilo.Router.Route (class RouteRouter, RouteMatch, orElse, routeRouter)
import Jarilo.Server.Request as Server
import Jarilo.Types (Junction, JunctionChain, NamedRoute)
import Prim.Row (class Cons)
import Record (get)
import Type.Proxy (Proxy(..))

class JunctionRouter (junction :: Junction) handlers | junction -> handlers where
    junctionRouter :: Proxy junction -> Record handlers -> Server.Request -> RouteMatch

instance
    ( RouteRouter route handler
    , Cons name handler handlers' handlers
    , IsSymbol name
    ) =>
    JunctionRouter (NamedRoute name route) handlers where
    junctionRouter _ handlers request =
        routeRouter (Proxy :: _ route) (get (Proxy :: _ name) handlers) request

instance
    ( JunctionRouter leftJunction handlers
    , JunctionRouter rightJunction handlers
    ) =>
    JunctionRouter (JunctionChain leftJunction rightJunction) handlers where
    junctionRouter _ handlers request =
        junctionRouter (Proxy :: _ leftJunction) handlers request
        `orElse` \_ -> junctionRouter (Proxy :: _ rightJunction) handlers request
