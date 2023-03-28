defmodule ChatProgramming.ChatHistory do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChatProgramming.ChatHistory, as: Ele
  alias ChatProgramming.{Repo, Space}

  schema "chat_history" do
    field :prompt, :string
    field :result, :string
    belongs_to :space, Space
    timestamps()
  end

  def get_by_id(id) do
    Repo.get_by(Ele, id: id)
  end

  def create(attrs \\ %{}) do
    %Ele{}
    |> Ele.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Ele{} = ele, attrs) do
    ele
    |> changeset(attrs)
    |> Repo.update()
  end

  def changeset(%Ele{} = ele) do
    Ele.changeset(ele, %{})
  end

  @doc false
  def changeset(%Ele{} = ele, attrs) do
    ele
    |> cast(attrs, [:prompt, :result, :space_id])
  end
end
