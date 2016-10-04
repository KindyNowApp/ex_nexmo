
ex_nexmo
========
[![Build Status](https://secure.travis-ci.org/kindynowapp/ex_nexmo.png?branch=master "Build Status")](http://travis-ci.org/kindynowapp/ex_nexmo)
[![Coverage Status](https://coveralls.io/repos/kindynowapp/ex_nexmo/badge.svg?branch=master&service=github)](https://coveralls.io/github/kindynowapp/ex_nexmo?branch=master)
[![hex.pm version](https://img.shields.io/hexpm/v/ex_nexmo.svg)](https://hex.pm/packages/ex_nexmo)
[![hex.pm downloads](https://img.shields.io/hexpm/dt/ex_nexmo.svg)](https://hex.pm/packages/ex_nexmo)
[![Inline docs](http://inch-ci.org/github/kindynowapp/ex_nexmo.svg?branch=master&style=flat)](http://inch-ci.org/github/kindynowapp/ex_nexmo)

A Nexmo API client for Elixir.

You can find the hex package [here](https://hex.pm/packages/ex_nexmo), and the docs [here](http://hexdocs.pm/ex_nexmo).

## Usage

```elixir
def deps do
  [{:ex_nexmo, "~> 0.1.0"}]
end
```

Then run `$ mix do deps.get, compile` to download and compile your dependencies.

You'll need to set a few config parameters, some in your app config, some, like
API credentials, we recommend keeping as environment viarables: take a look in
the `lib/config.ex` file to see what is required.

Then sending a text message is as easy as:

```elixir
ExNexmo.send_sms(from, to, message)
```

