defmodule Taihou.ResponseController do
  import Plug.Conn
  @token "kOIDQ35D18n9STwY2WJVNJY0"

  def respond(conn, %{"token" => token, "command" => "/react"} = params) when token == @token do
    url = fetch_url(params["text"])
    channel_id = Map.fetch!(params, "channel_id")

    IO.puts("sending response: #{url}")
    send_resp(conn, 200, url)
  end

  def respond(conn, params) do
    IO.puts("failing:")
    IO.puts(Jason.encode!(params))

    send_resp(conn, 400, "unknown command")
  end

  defp fetch_url(nil), do: "wat"
  defp fetch_url(text), do: text
end
