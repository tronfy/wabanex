defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "user query" do
    test "if id is valid, returns the user", %{conn: conn} do
      params = %{name: "Nicolas", email: "nicolas@wabanex.com", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}") {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected = %{
        "data" => %{
          "getUser" => %{
            "email" => "nicolas@wabanex.com",
            "name" => "Nicolas"
          }
        }
      }

      assert expected == response
    end

    test "if id is invalid, returns an error", %{conn: conn} do
      query = """
        {
          getUser(id: "") {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{
               "errors" => [
                 _error
               ]
             } = response
    end

    test "if user does not exist, returns an error", %{conn: conn} do
      query = """
        {
          getUser(id: "52d766a1-1a7d-4a7f-9bd5-4ae8dcbf2b25") {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{
               "data" => %{"getUser" => nil},
               "errors" => [
                 %{
                   "locations" => _locations,
                   "message" => "user not found",
                   "path" => ["getUser"]
                 }
               ]
             } = response
    end
  end

  describe "user mutation" do
    test "if all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Nicolas"
            email: "nicolas@wabanex.com"
            password: "123456"
          }) {
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createUser" => %{
                   "email" => "nicolas@wabanex.com",
                   "id" => _id,
                   "name" => "Nicolas"
                 }
               }
             } = response
    end
  end
end
