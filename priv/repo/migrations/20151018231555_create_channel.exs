defmodule PulseApi.Repo.Migrations.CreateChannel do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :community_id, :integer

      add :name, :string

      timestamps
    end

  end
end
