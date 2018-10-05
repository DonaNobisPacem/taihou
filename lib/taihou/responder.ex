defmodule Taihou.ResponseController do
  import Plug.Conn

  def respond(conn, params) do
    IO.puts(params)

    send_resp(conn, 200, "hi")
  end
end
