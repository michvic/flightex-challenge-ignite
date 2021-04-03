defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  alias Flightex.Users.Agent, as: UserAgent

  import Flightex.Factory

  describe "save/1" do
    test "save the user" do
      UserAgent.start_agent(%{})

      user = build(:user)

      assert {:ok, _uuid} = UserAgent.save(user)
    end
  end

  describe "get/1" do
    test "when the user is found, return the user" do
      UserAgent.start_agent(%{})

      {:ok, user_id} =
        :user
        |> build()
        |> UserAgent.save()

      respose = UserAgent.get(user_id)

      assert {:ok, _user} = respose
    end

    test "when the user is not found, return an error" do
      UserAgent.start_agent(%{})

      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
