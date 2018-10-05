defmodule TaihouTest do
  use ExUnit.Case
  doctest Taihou

  test "greets the world" do
    assert Taihou.hello() == :world
  end
end
