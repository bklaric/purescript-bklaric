Taken over from purescript-untagged-union 1.0.0

Added to Union:
else instance (Castable (Array a) (Array h)) => InOneOf (Array a) (Array h) t
else instance (Castable (Array a) (Array t)) => InOneOf (Array a) h (Array t)
else instance (Castable (Record a) (Record h)) => InOneOf (Record a) (Record h) t
else instance (Castable (Record a) (Record t)) => InOneOf (Record a) h (Record t)

Added to Castable:
instance castableArray :: Castable a b => Castable (Array a) (Array b)

Added to TypeCheck:
instance hasRuntimeTypeLiteral :: (HasRuntimeType t, IsSymbol s) => HasRuntimeType (Literal t s) where
  hasRuntimeType _ value = reflectSymbol (Proxy :: _ s) == unsafeCoerce value
