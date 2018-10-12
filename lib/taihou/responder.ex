defmodule Taihou.ResponseController do
  import Plug.Conn
  @token Application.get_env(:taihou, :token)

  def respond(conn, %{"token" => token, "command" => "/react"} = params) when token == @token do
    command =
      params
      |> Map.get("text", "")
      |> String.trim()
      |> String.split()
      |> List.first()
      |> String.downcase()

    response =
      case command do
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

        command ->
          construct_response(command)
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

  @angry ["angry"]
  @approve ["approve"]
  @celebrate ["celebrate"]
  @cry ["cry", "tears"]
  @delet ["delet"]
  @feelsbad ["feelsbad", "feelsbadman"]
  @feelsgood ["feelsgood", "feelsgoodman"]
  @hidoi ["hidoi"]
  @laugh ["lel", "lol", "haha", "lul"]
  @quote ["quote"]
  @reject ["reject"]
  @sugoi ["sugoi"]
  @wakarimasen ["dunno", "wakarimasen"]
  @wat ["wat", "nani", "whatthefuck", "nanithefuck"]

  @amen ""
  @angry_id "DfkhdZo"
  @approve_id "ywUT6b1"
  @celebrate_id "TcWTndc"
  @cry_id "nPcmJe4"
  @delet_id "aCjtxN6"
  @despair_id ""
  @disgust_id ""
  @dostedt_id ""
  @doubt_id ""
  @doubt_id "EghYsIq"
  @excited_id ""
  @fallback_id "TJwWJ6Z"
  @feelsbad_id "lCaH4Zn"
  @feelsgood_id "L1rp3Zl"
  @fight ""
  @gg ""
  @gtfo ""
  @happening ""
  @hidoi_id "UHcyXpI"
  @laugh_id "jEdfaZb"
  @mindblown_id ""
  @nani_id ""
  @no_id ""
  @panic_id ""
  @pity_id ""
  @quote_id "xwqPMC6"
  @reject_id "IkbwGtU"
  @scared_id ""
  @smug_id ""
  @stupid_id ""
  @sugoi_id "w6UFjuc"
  @sweating_id ""
  @thed ""
  @toolate ""
  @wakarimasen_id "WDtcrqs"
  @wat_id "3M3FnHd"
  @yamete_id ""
  @yes_id ""

  defp commands do
    @angry ++
      @approve ++
      @celebrate ++
      @cry ++
      @delet ++
      @feelsbad ++
      @feelsgood ++ @hidoi ++ @laugh ++ @quote ++ @reject ++ @sugoi ++ @wakarimasen ++ @wat
  end

  defp fetch_url(text) when text in @angry, do: Taihou.API.get_link(@angry_id)
  defp fetch_url(text) when text in @approve, do: Taihou.API.get_link(@approve_id)
  defp fetch_url(text) when text in @celebrate, do: Taihou.API.get_link(@celebrate_id)
  defp fetch_url(text) when text in @cry, do: Taihou.API.get_link(@cry_id)
  defp fetch_url(text) when text in @delet, do: Taihou.API.get_link(@delet_id)
  defp fetch_url(text) when text in @feelsbad, do: Taihou.API.get_link(@feelsbad_id)
  defp fetch_url(text) when text in @feelsgood, do: Taihou.API.get_link(@feelsgood_id)
  defp fetch_url(text) when text in @hidoi, do: Taihou.API.get_link(@hidoi_id)
  defp fetch_url(text) when text in @laugh, do: Taihou.API.get_link(@laugh_id)
  defp fetch_url(text) when text in @quote, do: Taihou.API.get_link(@quote_id)
  defp fetch_url(text) when text in @reject, do: Taihou.API.get_link(@reject_id)
  defp fetch_url(text) when text in @sugoi, do: Taihou.API.get_link(@sugoi_id)
  defp fetch_url(text) when text in @wakarimasen, do: Taihou.API.get_link(@wakarimasen_id)
  defp fetch_url(text) when text in @wat, do: Taihou.API.get_link(@wat_id)
  defp fetch_url(_text), do: Taihou.API.get_link(@fallback_id)
end
