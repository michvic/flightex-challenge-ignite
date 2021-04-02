defmodule Flightex.Bookings.Create do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def call(user_id, %{
        day: day,
        month: month,
        year: year,
        leaving_from: leaving_from,
        going_to: going_to
      }) do
    with {:ok, user} <- UserAgent.get(user_id),
         {:ok, booking} <-
           Booking.build(nil, day, month, year, leaving_from, going_to, user) do
      BookingAgent.save(booking)
    else
      error -> error
    end
  end
end
