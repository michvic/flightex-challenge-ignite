defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  alias Flightex.Bookings.Agent, as: BookingAgent

  import Flightex.Factory

  describe "save/1" do
    test "save the booking" do
      BookingAgent.start_agent(%{})

      booking = build(:booking)

      assert {:ok, _uuid} = BookingAgent.save(booking)
    end
  end

  describe "get/1" do
    test "when the user is found, return the booking" do
      BookingAgent.start_agent(%{})

      {:ok, booking_id} =
        :booking
        |> build()
        |> BookingAgent.save()

      respose = BookingAgent.get(booking_id)

      assert {:ok, _booking} = respose
    end

    test "when the booking is not found, return an error" do
      BookingAgent.start_agent(%{})

      response = BookingAgent.get("00000000000")

      expected_response = {:error, "Flight Booking not found"}

      assert response == expected_response
    end
  end
end
