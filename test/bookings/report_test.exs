defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Report
  alias Flightex.Users.Agent, as: UserAgent

  import Flightex.Factory

  describe "create/3" do
    test "create um report file flight bookings" do
      Flightex.start_agents()

      :user
      |> build()
      |> UserAgent.save()

      :booking
      |> build()
      |> BookingAgent.save()

      :booking
      |> build(cidade_origem: "São Luís")
      |> BookingAgent.save()

      Report.create("2021-01-01", "2021-12-30", "report_test.csv")

      response = File.read!("report_test.csv")

      expected_response =
        "1,Belém,São Paulo,2021-04-01 00:00:00\n" <>
          "1,São Luís,São Paulo,2021-04-01 00:00:00\n"

      assert expected_response == response
    end
  end
end
