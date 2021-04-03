defmodule Flightex.Bookings.Booking do
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]

  @enforce_keys @keys

  alias Flightex.Users.User

  defstruct @keys

  def build(id, day, month, year, leaving_from, going_to, %User{id: uuid})
      when day > 0 and month > 0 and year > 0 do
    {:ok,
     %__MODULE__{
       id: id,
       data_completa: parser_naive_date_time(day, month, year),
       cidade_origem: leaving_from,
       cidade_destino: going_to,
       id_usuario: uuid
     }}
  end

  def build(_id, _day, _month, _year, _leaving_from, _going_to, _user),
    do: {:error, "Ivalid parameters"}

  defp parser_naive_date_time(day, month, year), do: NaiveDateTime.new!(year, month, day, 0, 0, 0)
end
