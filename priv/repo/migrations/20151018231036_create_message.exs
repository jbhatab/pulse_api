defmodule PulseApi.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :user_id, :integer
      add :channel_id, :integer

      add :body, :string

      timestamps
    end

  end
end
