defmodule PulseApi.User do
  use PulseApi.Web, :model

  schema "users" do
    has_many :messages, Message

    field :username, :string
    field :firstname, :string
    field :lastname, :string
    field :email, :string

    timestamps
  end

  @required_fields ~w(username)
  @optional_fields ~w(firstname lastname email)

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
