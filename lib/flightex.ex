defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Create, as: BookingCreate
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.Create, as: UserCreate

  def start_agents() do
    {:ok, pid1} = BookingAgent.start_agent(%{})
    {:ok, pid2} = UserAgent.start_agent(%{})

    %{"users" => pid1, "bookings" => pid2}
  end

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate create_booking(user_id, params), to: BookingCreate, as: :call
  defdelegate get_booking(id), to: BookingAgent, as: :get
end
