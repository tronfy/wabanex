defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "if all params are valid, returns a valid changeset" do
      params = %{name: "Nícolas", email: "nicolas@wabanex.com", password: "123456"}
      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: ^params,
               errors: []
             } = response
    end

    test "if there are invalid params, returns an invalid changeset" do
      params = %{}
      response = User.changeset(params)

      expected = %{
        email: ["can't be blank"],
        name: ["can't be blank"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected
    end
  end
end
