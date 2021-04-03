defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_factory do
    %User{
      id: 1,
      name: "Michel",
      email: "mich@t.com",
      cpf: "78956712300"
    }
  end

  def booking_factory do
    user = build(:user)

    %Booking{
      id: 1,
      data_completa: NaiveDateTime.new!(2021, 04, 01, 0, 0, 0),
      cidade_origem: "Belém",
      cidade_destino: "São Paulo",
      id_usuario: user.id
    }
  end
end
