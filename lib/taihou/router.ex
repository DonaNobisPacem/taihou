defmodule Taihou.Router do
  use Plug.Router

  plug(Plug.Parsers, parsers: [:urlencoded])
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "")
  end

  post "/" do
    Taihou.ResponseController.respond(conn, conn.params)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
