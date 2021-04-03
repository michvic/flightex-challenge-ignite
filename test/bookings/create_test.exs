defmodule Flightex.Bookings.CreateTest do
  use ExUnit.Case

  alias Flightex.Bookings.Create
  alias Flightex.Users.Agent, as: UserAgent

  import Flightex.Factory

  describe "call/1" do
    setup do
      Flightex.start_agents()

      {:ok, user_id} =
        :user
        |> build()
        |> UserAgent.save()

      {:ok, user_id: user_id}
    end

    test "when all params are valid, save the flight booking", %{user_id: user_id} do
      params = %{
        day: 1,
        month: 4,
        year: 2021,
        leaving_from: "São Luis",
        going_to: "Gôiania"
      }

      response = Create.call(user_id, params)

      assert {:ok, _uuid} = response
    end

    test "when user id is not valid, return an error" do
      user_id = 0

      params = %{
        day: 1,
        month: 4,
        year: 2021,
        leaving_from: "São Luis",
        going_to: "Gôiania"
      }

      response = Create.call(user_id, params)

      expected_response = {:error, "User not found"}

      assert expected_response == response
    end

    test "when there are invalid params, return an error", %{user_id: user_id} do
      params = %{
        day: 0,
        month: 4,
        year: 2021,
        leaving_from: "São Luis",
        going_to: "Gôiania"
      }

      response = Create.call(user_id, params)

      expected_response = {:error, "Ivalid parameters"}

      assert expected_response == response
    end
  end
end
