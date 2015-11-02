defmodule PulseApi.UserTest do
  use PulseApi.ModelCase

  alias PulseApi.User

  @valid_attrs %{email: "some content", firstname: "some content", lastname: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
