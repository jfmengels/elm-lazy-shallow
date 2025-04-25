# Elm LazyShallow

An extension to Elm's core [`Html.Lazy`](https://package.elm-lang.org/packages/elm/html/latest/Html-Lazy) module, which provides a function that allows applying laziness to a view function with an arbitrary number of arguments through a record argument. **This requires patching the compiled Elm code**.

## Contents

This is an example repository that you can copy into your project. It includes a `Html.LazyExtra.lazyShallow` function as well as a an example script to patch the compiled Elm code.

Here's how to use it:

```elm
Html.LazyExtra.lazyShallow myViewFunction
    { lazyDummy = ()
    , arg1 = arg1
    , arg2 = arg2
    , arg3 = arg3
    , arg4 = arg4
    , arg5 = arg5
    , arg6 = arg6
    , arg7 = arg7
    , arg8 = arg8
    , arg9 = arg9 -- OVER 8 ARGUMENTS!!!
    }

myViewFunction params =
  Html.div [] [ Html.text "..." ]
```

## Example

Clone this repository and run the following commands (requires Node.js):

```sh
elm make src/Main.elm --output elm.js
node ./patch.js elm.js elm-patched.js
```

The `elm.js` file is the usual compiled Elm output that you're used to.
The `elm-patched.js` is the same but the definition for `$author$project$Html$LazyExtra$lazyShallow` (the `Html.LazyExtra.lazyShallow` function) has been modified to include lazy magic.

You can try both results by opening `index.html` and `index-patched.html`.
If you open the developer console, you'll see a lot of Debug logs in the former (every 200ms), but in the patched version you will only see it when interacting with the counter buttons.


## Use in your project

To use in your project:
1. Copy over the `Html/LazyExtra.elm` file to your project.
2. Set up patching in your project

For the patching, you can use `patch.js` as an inspiration. It can be much simpler (it's a simple find and replace), or it can be more involved. A good idea would be to report an error if the patching did not work because the expected input was not found.

Feel free to provide other patching scripts or methods to be included in this example repository.

Feel free to rename everything, but if you do so don't forget to update your patching script as it is looking for a specific name for the lazy function.

The base Elm code is written in a way so that if patching failed to apply, the code still works as expected (but without the lazy magic).


## WARNINGS

This patches the compiled Elm output, and therefore includes some risks.

1. This approach could not work in future versions of Elm. Who knows what the future brings (or maybe this function is now provided by the core).
2. This could potentially not interact well with other tools that are run before (other patch scripts) or afterwards (minifiers).
3. If you make changes to the files given here, do verify that the patch works in both development AND `--optimize` mode, as the output can be different.
4. Bad patching can lead to runtime errors.
5. If you ever choose to patch other things, try to keep the Elm spirit of everything being pure, otherwise you may end up with weird results.

Apply but verify, at your own risk.