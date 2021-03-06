defmodule ElixirScript.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir_script,
      version: "0.6.0-dev",
      elixir: "~> 1.0",
      compilers: Mix.compilers,
      escript: escript_config,
      deps: deps,
      description: description,
      package: package,
      source_url: "https://github.com/bryanjos/elixirscript",
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [applications: [:logger, :poison]]
  end

  defp deps do
    [
      { :poison, "~> 1.4" },
      { :inflex, "~> 1.0" },
      { :estree, github: "bryanjos/elixir-estree"},
      { :excoveralls, only: [:dev, :test] },
      { :shouldi, github: "batate/shouldi", only: :test },
      { :mix_test_watch, github: "lpil/mix-test.watch" }
    ]
  end

  defp escript_config do
    [main_module: ElixirScript.CLI, name: "ex2js"]
  end

  defp description do
    """
    converts Elixir to JavaScript
    """
  end

  defp package do
    [ # These are the default files included in the package
      files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*", "CHANGELOG*", "escodegen"],
      contributors: ["Bryan Joseph"],
      licenses: ["MIT"],
      links: %{ 
        "GitHub" => "https://github.com/bryanjos/elixirscript"
      }
    ]
  end
  
end
