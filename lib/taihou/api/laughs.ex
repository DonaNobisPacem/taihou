defmodule Taihou.API.Laughs do
  @album_key "jEdfaZb"
  @fallback "lel.exe"

  def get_link do
    HTTPoison.start()
    url = Application.get_env(:taihou, :imgur_api) <> @album_key
    headers = [Authorization: "Client-ID #{Application.get_env(:taihou, :imgur_client_id)}"]
    response = HTTPoison.get!(url, headers)

    with 200 <- response.status_code,
         body <- Jason.decode!(response.body),
         data <- Map.get(body, "data", %{}),
         image_list <- Map.get(data, "images", []) do
      image_list
      |> Enum.random()
      |> Map.get("link", @fallback)
    else
      _resp ->
        @fallback
    end
  end
end
