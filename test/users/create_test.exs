defmodule Flightex.Users.CreateTest do
  use ExUnit.Case

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.Create

  describe "call/1" do
    setup do
      UserAgent.start_agent(%{})
      :ok
    end

    test "when all params are valid, save the user" do
      params = %{
        name: "Michel",
        email: "mich@t.com",
        cpf: "78956712300"
      }

      response = Create.call(params)

      assert {:ok, _uuid} = response
    end

    test "when there are invalid params, return an error" do
      params = %{
        name: "Michel",
        email: "mich@t.com",
        cpf: 0
      }

      response = Create.call(params)

      expected_response = {:error, "Ivalid parameters"}

      assert expected_response == response
    end
  end
end
