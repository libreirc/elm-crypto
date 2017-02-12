elm-crypto [![Build Status]][Travis CI]
========
Cryptographic random number generation for Elm.

A simple wrapper around the [`window.crypto.getRandomValues`] API to generate
cryptographic random values in Elm.

Example
--------
Random generation function return a [`Task`]. Depending on your use case, you
might want to convert the task to an `Effects` or otherwise use it.

Assuming you're using [evancz/start-app], in your `update` function:

```elm
update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Toss ->
      ( model
      , SecureRandom.bool -- generating a random Bool value here
          |> Task.toMaybe
          |> Task.map Catch
          |> Effects.task
      )

    Catch coin ->
      ({ model | coin = coin }, Effects.none)
```

TODOs
--------
- [ ] Check if it fails gracefully with IE 10, IE 9, etc
- [ ] Test automation
- [ ] CI the sample app
- [ ] Introduce `InvalidArgument` Error

<br>

--------
*elm-crypto* is primarily distributed under the terms of both the [MIT
license] and the [Apache License (Version 2.0)]. See [COPYRIGHT] for details.

[Build Status]: https://travis-ci.org/openirc/elm-crypto.svg?branch=master
[Travis CI]: https://travis-ci.org/openirc/elm-crypto
[`window.crypto.getRandomValues`]: https://developer.mozilla.org/en-US/docs/Web/API/RandomSource/getRandomValues
[`Task`]: http://package.elm-lang.org/packages/elm-lang/core/latest/Task
[evancz/start-app]: https://github.com/evancz/start-app
[MIT license]: LICENSE-MIT
[Apache License (Version 2.0)]: LICENSE-APACHE
[COPYRIGHT]: COPYRIGHT
