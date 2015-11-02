defmodule PulseApi.CommunityTest do
  use PulseApi.ModelCase

  alias PulseApi.Community

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Community.changeset(%Community{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Community.changeset(%Community{}, @invalid_attrs)
    refute changeset.valid?
  end
end
