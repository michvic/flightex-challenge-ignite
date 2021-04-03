defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case

  alias Flightex.Bookings.Booking

  import Flightex.Factory

  describe "build/7" do
    test "when all params are valid, returns a booking" do
      user = build(:user)

      response = Booking.build(1, 01, 04, 2021, "Belém", "São Paulo", user)

      expected_response = {:ok, build(:booking)}

      assert expected_response == response
    end

    test "when there are invalid params, returns an error" do
      user = %{}

      response = Booking.build(1, 1, 04, 2021, "Belém", "São Paulo", user)

      expected_response = {:error, "Ivalid parameters"}

      assert expected_response == response
    end
  end
end
