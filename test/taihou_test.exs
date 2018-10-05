defmodule TaihouTest do
  use ExUnit.Case, async: true
  import Plug.Test
  doctest Taihou

  @opts Taihou.Router.init([])
  test "responds with 400 when token is invalid" do
    conn = conn(:post, "/", %{token: "wat"})
    conn = Taihou.Router.call(conn, @opts)

    assert {400, _, _} = sent_resp(conn)
  end

  test "responds with 200 when token is valid" do
    conn =
      conn(:post, "/", %{
        token: Application.get_env(:taihou, :token),
        command: "/react",
        text: "wat"
      })

    conn = Taihou.Router.call(conn, @opts)

    assert {200, _, _} = sent_resp(conn)
  end
end
