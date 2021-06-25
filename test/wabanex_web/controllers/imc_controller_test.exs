defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "if all params are valid, returns the imc", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected = %{
        "result" => %{
          "Dani" => 23.437499999999996,
          "Diego" => 23.04002019946976,
          "Gabul" => 22.857142857142858,
          "Rafael" => 24.897060231734173,
          "Rodrigo" => 26.234567901234566
        }
      }

      assert expected == response
    end

    test "if there are invalid params, returns an error", %{conn: conn} do
      params = %{"filename" => ""}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected = %{"result" => "Error while reading file"}

      assert expected == response
    end
  end
end
