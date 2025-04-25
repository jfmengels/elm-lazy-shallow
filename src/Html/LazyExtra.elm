module Html.LazyExtra exposing (lazyShallow)

import Html exposing (Html)


{-| A performance optimization that delays the building of virtual DOM nodes.

This is meant to be used when the lazy functions run out of arguments, ie when `Html.Lazy.lazy8` is not enough.

    Html.LazyExtra.lazyShallow someViewFunction
        { lazyDummy = ()
        , someOtherField1 = ...
        , someOtherField2 = ...
        , ...
        }

NOTE 1: This only works because we patch this function in `<script-that-patches-the-output>.js`.

NOTE 2: The `lazyDummy` field is only there to ensure that the argument to that function is a plain Elm record.

-}
lazyShallow : ({ a | lazyDummy : () } -> Html msg) -> { a | lazyDummy : () } -> Html msg
lazyShallow func a =
    func a
