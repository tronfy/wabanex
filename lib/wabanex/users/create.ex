defmodule Wabanex.Users.Create do
  alias Wabanex.{User, Repo}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
