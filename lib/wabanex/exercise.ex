defmodule Wabanex.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wabanex.Training

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:name, :protocol_description, :repetitions, :youtube_video_url]

  schema "exercises" do
    field :name, :string, null: false
    field :protocol_description, :string, null: false
    field :repetitions, :string, null: false
    field :youtube_video_url, :string, null: false

    belongs_to :training, Training

    timestamps()
  end

  def changeset(exercise, params) do
    exercise
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end

params = %{
  user_id: "c6f0cdc0-c73a-4088-bb1a-b723f9645252",
  start_date: "2021-06-22",
  end_date: "2021-07-22",
  exercises: [
    %{
      name: "Triceps banco",
      protocol_description: "regular",
      repetitions: "3x12",
      youtube_video_url: "www.youtube.com"
    },
    %{
      name: "Triceps banco",
      protocol_description: "regular",
      repetitions: "3x12",
      youtube_video_url: "www.youtube.com"
    }
  ]
}
