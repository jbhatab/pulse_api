# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PulseApi.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

community = PulseApi.Repo.insert!(%PulseApi.Community{name: "Open Minded Innovations"})

PulseApi.Repo.insert!(%PulseApi.Channel{name: "General", community_id: community.id})
PulseApi.Repo.insert!(%PulseApi.Channel{name: "Random", community_id: community.id})