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

  @laugh_id "jEdfaZb"
  @laugh ["lel", "lol", "haha", "lul"]
  @wat_id "3M3FnHd"
  @wat ["wat", "nani", "what the fuck", "nani the fuck"]
  @feelsbad_id "lCaH4Zn"
  @feelsbad ["feelsbad", "feelsbadman"]
  defp commands, do: @laugh ++ @cry ++ @feelsbad

  defp fetch_url("ptsd"), do: "https://i.imgur.com/xpvHDl8.jpg"
  defp fetch_url(text) when text in @laugh, do: Taihou.API.get_link(@laugh_id)
  defp fetch_url(text) when text in @wat, do: Taihou.API.get_link(@wat_id)
  defp fetch_url(text) when text in @feelsbad, do: Taihou.API.get_link(@feelsbad_id)
  defp fetch_url(text), do: text
end
