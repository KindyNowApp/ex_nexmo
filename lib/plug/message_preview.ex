if Code.ensure_loaded?(Plug) do
  defmodule Plug.ExNexmo.MessagePreview do

    @moduledoc """
    A simple plug to view messages when ExNexmo is used in a web app.
    """

    use Plug.Router
    use Plug.ErrorHandler
    alias ExNexmo.SMS.Local
    alias Plug.HTML

    require EEx
    EEx.function_from_file :defp, :template, "lib/plug/templates/message_viewer/index.html.eex", [:assigns]

    def call(conn, opts) do
      conn =
        conn
        |> assign(:base_path, opts[:base_path] || "")
      super(conn, opts)
    end

    plug :match
    plug :dispatch

    get "/" do
      messages = Local.all
      conn
      |> put_resp_content_type("text/html")
      |> send_resp(200, template(messages: messages, message: nil, conn: conn))
    end

    get "/:id" do
      messages = Local.all
      message = Local.get(String.to_integer(id))
      conn
      |> put_resp_content_type("text/html")
      |> send_resp(200, template(messages: messages, message: message, conn: conn))
    end

    defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
      send_resp(conn, conn.status, "Something went wrong")
    end

    defp to_absolute_url(conn, path) do
      URI.parse("#{conn.assigns.base_path}/#{path}").path
    end

    defp render_recipient(recipient) when is_binary(recipient) do
      HTML.html_escape(recipient)
    end

    defp render_recipient(_) do
      "None"
    end

  end
end

