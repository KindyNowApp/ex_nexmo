defmodule ExNexmo.SMS.Local do

  @moduledoc """
  A local in-memory message store that allows messages send to be viewed in
  development when ExNexmo is used in a web app.
  """

  use GenServer
  alias ExNexmo.SMS.Response
  require Logger
  import Poison, only: [decode!: 1, encode!: 1]

  @doc false
  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc false
  def init(messages) do
    {:ok, {messages, 0}}
  end

  @doc false
  def handle_call({:push, message}, _from, {messages, last_message_id}) do
    message = Map.put(message, "message_id", last_message_id)
    {:reply, last_message_id, {[message|messages], last_message_id + 1}}
  end

  @doc false
  def handle_call(:all, _from, {messages, _} = state) do
    {:reply, messages, state}
  end

  @doc false
  def handle_call({:get, message_id}, _from, {messages, _} = state) do
    message = Enum.find(messages, fn %{"message_id" => id} ->
      id == message_id
    end)
    {:reply, message, state}
  end

  @spec deliver(String.t) :: {atom, Response.t}
  @spec deliver(map) :: {atom, Response.t}

  def deliver(json) when is_binary(json) do
    json
    |> decode!
    |> deliver
  end

  def deliver(%{"to" => to} = payload) do
    message_id = push(payload)
    response =
      %{
        message_count: "1",
        messages: [%{
          status: "0",
          message_id: Integer.to_string(message_id),
          to: to,
          message_price: "100",
          client_ref: "1234",
          network: "network"
        }]
      }
      |> encode!
      |> Response.parse
    {:ok, response}
  end

  @doc """
  Gets all the stored messages.
  """
  @spec all :: list
  def all do
    GenServer.call(__MODULE__, :all)
  end

  @doc """
  Gets a specific stored message.
  """
  @spec get(integer) :: map
  def get(message_id) do
    GenServer.call(__MODULE__, {:get, message_id})
  end

  @spec push(map) :: integer
  defp push(message) do
    GenServer.call(__MODULE__, {:push, message})
  end

end
