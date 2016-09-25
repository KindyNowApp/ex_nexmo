defmodule ExNexmo do

  @moduledoc """
  TODO
  """

  use Application

  @doc false
  def start(_, _) do
    import Supervisor.Spec, warn: false
    children = [
      # TODO
    ]
    opts = [strategy: :one_for_one, name: ExNexmo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc false
  def stop(_) do
    # noop
  end

end
