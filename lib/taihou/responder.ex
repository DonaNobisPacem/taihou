defmodule Taihou.ResponseController do
  import Plug.Conn
  @token Application.get_env(:taihou, :token)

  def respond(conn, %{"token" => token, "command" => "/react"} = params) when token == @token do
    text = params |> Map.get("text", "") |> String.downcase()

    response =
      case text do
        "" ->
          construct_response("brain problems")

        "commands" ->
          commands()
          |> Enum.sort()
          |> Enum.join(", ")
          |> construct_response(%{"response_type" => "ephemeral"})

        "help" ->
          construct_response(
            "To use this weeb app, provide a keyword after `/react`. Use `/react commands` to get the list.",
            %{"response_type" => "ephemeral"}
          )

        text ->
          construct_response(text)
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, response)
  end

  def respond(conn, _params) do
    send_resp(conn, 400, "unknown command")
  end

  defp construct_response(response_text, opts \\ %{}) do
    response_type = Map.get(opts, "response_type", "in_channel")
    response_url = fetch_url(response_text)
    attachments = Map.get(opts, "attachments", %{})

    Jason.encode!(%{
      "response_type" => response_type,
      "text" => response_url,
      "attachments" => attachments
    })
  end

  @laugh ["lel", "lol", "haha", "lul"]
  @laugh_id "jEdfaZb"
  @cry ["cry", "tears"]
  @wat ["wat", "nani", "what the fuck", "nani the fuck"]
  defp commands, do: @laugh ++ @cry ++ @wat
  defp fetch_url("ptsd"), do: "https://i.imgur.com/xpvHDl8.jpg"
  defp fetch_url(text) when text in @laugh, do: Taihou.API.get_link(@laugh_id)
  defp fetch_url(text), do: text
end
