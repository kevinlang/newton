defmodule Newton do
  @external_resource "README.md"
  @moduledoc "README.md"
             |> File.read!()
            #  |> String.split("<!-- MDOC !-->")
            #  |> Enum.fetch!(1)

  @doc false
  defmacro __using__(_opts) do
    quote do
      unquote(router())
      unquote(application())
    end
  end

  defp router() do
    quote do
      use Plug.Router
      use PlugSocket
      import Newton.Helpers

      plug :match
      plug :dispatch
    end
  end

  defp application() do
    quote do
      use Application

      def start(_type, args) do
        Newton.Supervisor.start_link(__MODULE__, args)
      end

      @doc """
      Returns the child specification to start the endpoint
      under a supervision tree.
      """
      def child_spec(opts) do
        %{
          id: __MODULE__,
          start: {__MODULE__, :start_link, [opts]},
          type: :supervisor
        }
      end

      def start_link(opts \\ []) do
        Newton.Supervisor.start_link(__MODULE__, opts)
      end
    end
  end
end
