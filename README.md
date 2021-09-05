# Newton

Newton is a [DSL](https://en.wikipedia.org/wiki/Domain-specific_language) for quickly creating Elixir web applications with minimal effort:

```elixir
# lib/my_app.ex
defmodule MyApp do
  use Newton
  
  get "/" do
    text(conn, "Hello world!")
  end
end
```

Install the Hex package by adding it to your deps, and specify your application module:

```elixir
# mix.exs
defmodule MyApp.MixProject do
  #...

  def application do
    [
      extra_applications: [:logger],
      mod: {MyApp, []}
    ]
  end

  defp deps do
    [{:newton, "~> 0.1.0"}]
  end
end
```

Install your package:

```bash
mix deps.get
```

And run with:

```bash
mix run --no-halt mix.exs
```

View at: http://localhost:5678

The code you changed will not take effect until you restart the server. Please restart the server every time you change or use [`newton_reload`](https://github.com/kevinlang/newton_reload).

## Supervision

In addition to being started as an application directly, your Newton server can also be started under your application's supervision tree.

Simply update your `MyApp.Application` to include it:

```elixir
children = [
  {MyApp, []}
]
```

## Routes

In Newton, a route is an HTTP method paired with a URL-matching pattern. Each route is associated with a block:

```elixir
get "/" do
  .. show something ..
end

post "/" do
  .. create something ..
end

put "/" do
  .. replace something ..
end

patch "/" do
  .. modify something ..
end

delete "/" do
  .. annihilate something ..
end

options "/" do
  .. appease something ..
end
```

Each route receives a `conn` variable containing a `Plug.Conn` struct. 

Routes with a trailing slash are different from the ones without:

```elixir
get "/foo" do
  # Does not match "GET /foo/"
end
```

Route patterns may include named parameters which will be available in the function body:

```elixir
get "/greet/:name" do
  text(conn, "Hello #{name}")
end
```

You can also access named parameters via `conn.params` and `conn.path_params`:

```elixir
get "/law-of-identity/:value" do
  text(conn, "#{conn.params[:name]} == #{conn.path_params[:name]}")
end
```

Route patterns may also include glob-like patterns to match trailing segments:

```elixir
get "/hello/*glob" do
  text(conn, "trailing: #{glob}")
end
```

TODO: param handling

TODO: passing function instead of block

TODO: passing module/atom pair instead of block


## Conditions



## Static Files

Static files are served from the `priv/static` directory under the root request path (`/`) automatically via `Plug.Static`. 

You can override the defaults by plugging it yourself:

```elixir
plug Plug.Static,
  at: "/public",
  from: "priv/other/path"
```

Alternatively, you can disable it entirely:

```elixir
set :serve_static, false
```

## View / Templates

Each template language is exposed via its own rendering method. 

```elixir
get "/" do
  eex "index"
end
```

This renders `templates/index.eex`

