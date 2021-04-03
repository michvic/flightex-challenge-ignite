defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  alias Flightex.Users.User

  import Flightex.Factory

  describe "build/4" do
    test "when all params are valid, returns the user" do
      response = User.build(1, "Michel", "mich@t.com", "78956712300")

      expected_response = {:ok, build(:user)}

      assert expected_response == response
    end

    test "when there are valid params, returns an error" do
      response = User.build(nil, "Michel", "mich@t.com", 0)

      expected_response = {:error, "Ivalid parameters"}

      assert expected_response == response
    end
  end
end
