defmodule ExNexmo.Mixfile do

  use Mix.Project

  def project do
    [
      app: :ex_nexmo,
      version: "0.1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test],
      description: "Elixir Nexmo API Client"
    ]
  end

  def application do
    [applications: [:logger, :httpoison],
      mod: {ExNexmo, []}]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8"},
      {:poison, "~> 2.2"},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:excoveralls, "~> 0.5", only: :test},
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev},
      {:dialyxir, "~> 0.3", only: :dev},
      {:credo, "~> 0.3", only: :dev},
      {:bypass, "~> 0.1", only: :test},
      {:inch_ex, "~> 0.5", only: :docs},
      {:bypass, "~> 0.1", only: :test}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      licenses: ["MIT"],
      maintainers: ["Craig Paterson", "Sina Karimi"],
      links: %{"Github" => "https://github.com/KindyNowApp/ex_nexmo"}
    ]
  end

end
