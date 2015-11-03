defmodule PulseApi.Message do
  use PulseApi.Web, :model

  schema "messages" do
    belongs_to :user, PulseApi.User
    belongs_to :channel, PulseApi.Channel

    field :body, :string

    timestamps
  end

  @required_fields ~w(body)
  @optional_fields ~w(channel_id user_id)

  def by_channel(query, channel_id) do
    from m in query,
    where: m.channel_id == ^channel_id
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
