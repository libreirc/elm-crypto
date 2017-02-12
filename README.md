elm-crypto
========
[Web Cryptography API] for Elm.

It wraps [`RandomSource.getRandomValues`] API to generator cryptographically
secure pseudorandom number in Elm.

Usage
--------
Random generation function return a [`Task`]. Depending on your use case, you
might want to convert the task to an [`Cmd`] or otherwise use it.

```elm
update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Toss ->
      let
        cmd = Task.perform Failed Catch Crypto.bool
      in (model, cmd)
    Catch coin -> ({ model | coin = Just coin }, Cmd.none)
```

| Build Status |
|--------------|
| [![Build Status]][Travis CI] |

<br>

--------
*elm-crypto* is primarily distributed under the terms of both the [MIT
license] and the [Apache License (Version 2.0)]. See [COPYRIGHT] for details.

[Web Cryptography API]: https://w3c.github.io/webcrypto/Overview.html
[`RandomSource.getRandomValues`]: https://developer.mozilla.org/en-US/docs/Web/API/RandomSource/getRandomValues
[`Task`]: http://package.elm-lang.org/packages/elm-lang/core/latest/Task
[`Cmd`]: http://package.elm-lang.org/packages/elm-lang/core/latest/Platform-Cmd
[Build Status]: https://travis-ci.org/openirc/elm-crypto.svg?branch=master
[Travis CI]: https://travis-ci.org/openirc/elm-crypto
[MIT license]: LICENSE-MIT
[Apache License (Version 2.0)]: LICENSE-APACHE
[COPYRIGHT]: COPYRIGHT
