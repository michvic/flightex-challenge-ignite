defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_agent(_initial_value), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%Booking{} = booking) do
    uuid = UUID.uuid4()

    booking = %{booking | id: uuid}

    Agent.update(__MODULE__, &update_state(&1, booking, uuid))

    {:ok, uuid}
  end

  defp update_state(state, %Booking{} = booking, uuid), do: Map.put(state, uuid, booking)

  def list_all, do: Agent.get(__MODULE__, & &1)

  def get(booking_id), do: Agent.get(__MODULE__, &get_booking(&1, booking_id))

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Flight Booking not found"}
      booking -> {:ok, booking}
    end
  end
end
