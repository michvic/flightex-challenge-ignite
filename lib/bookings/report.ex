defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def create(from_date, to_date, filename \\ "report.csv") do
    flight_bookings = build_bookings_list(from_date, to_date)

    File.write(filename, flight_bookings)
  end

  defp build_bookings_list(from_date, to_date) do
    {:ok, from_date} = Date.from_iso8601(from_date)
    {:ok, to_date} = Date.from_iso8601(to_date)

    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(&filter_bookings(&1, from_date, to_date))
  end

  defp filter_bookings(
         %Booking{
           data_completa: naive_date_time,
           cidade_origem: leaving_from,
           cidade_destino: going_to,
           id_usuario: id_usuario
         },
         from_date,
         to_date
       ) do
    with :lt <- Date.compare(from_date, naive_date_time),
         :gt <- Date.compare(to_date, naive_date_time) do
      "#{id_usuario},#{leaving_from},#{going_to},#{NaiveDateTime.to_string(naive_date_time)}\n"
    else
      _ ->
        ""
    end
  end
end
