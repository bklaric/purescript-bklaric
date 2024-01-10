module Control.Bind.LiftJoin where

import Prelude

import Control.Apply (lift2, lift3, lift4, lift5)

liftJoin2 :: forall f a b c. Bind f => (a -> b -> f c) -> f a -> f b -> f c
liftJoin2 f a b = join $ lift2 f a b

liftJoin3 :: forall f a b c d. Bind f => (a -> b -> c -> f d) -> f a -> f b -> f c -> f d
liftJoin3 f a b c = join $ lift3 f a b c

liftJoin4 :: forall f a b c d e. Bind f => (a -> b -> c -> d -> f e) -> f a -> f b -> f c -> f d -> f e
liftJoin4 f a b c d = join $ lift4 f a b c d

liftJoin5 :: forall f a b c d e g. Bind f => (a -> b -> c -> d -> e -> f g) -> f a -> f b -> f c -> f d -> f e -> f g
liftJoin5 f a b c d e = join $ lift5 f a b c d e
