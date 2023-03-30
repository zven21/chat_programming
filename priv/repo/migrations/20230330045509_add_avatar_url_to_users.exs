defmodule ChatProgramming.Repo.Migrations.AddAvatarUrlToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :nickname, :string
      add :avatar_url, :string
    end
  end
end
