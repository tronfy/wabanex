defmodule Wabanex.Repo.Migrations.CreateTrainingsTable do
  use Ecto.Migration

  def change do
    create table(:trainings) do
      add :user_id, references(:users)
      add :start_date, :date
      add :end_date, :date

      timestamps()
    end
  end
end
