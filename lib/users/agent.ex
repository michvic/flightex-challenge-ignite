defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_agent(_initial_value), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%User{} = user) do
    uuid = UUID.uuid4()

    user = %{user | id: uuid}

    Agent.update(__MODULE__, &update_state(&1, user))

    {:ok, uuid}
  end

  def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  def list_all, do: Agent.get(__MODULE__, & &1)

  defp update_state(state, %User{id: uuid} = user), do: Map.put(state, uuid, user)

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
