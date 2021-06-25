defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "if file exists, calculate imc" do
      params = %{"filename" => "students.csv"}
      response = IMC.calculate(params)

      expected =
        {:ok,
         %{
           "Dani" => 23.437499999999996,
           "Diego" => 23.04002019946976,
           "Gabul" => 22.857142857142858,
           "Rafael" => 24.897060231734173,
           "Rodrigo" => 26.234567901234566
         }}

      assert expected === response
    end

    test "if file does not exist, return an error" do
      params = %{"filename" => ""}
      response = IMC.calculate(params)

      expected = {:error, "Error while reading file"}

      assert expected === response
    end
  end
end
