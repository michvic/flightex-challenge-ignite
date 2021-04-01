defmodule Flightex.Users.Create do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(name, email, cpf) do
    name
    |> User.build(email, cpf)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)

    {:ok, "User creted successfuly"}
  end

  defp save_user({:error, _reason} = error), do: error
end
