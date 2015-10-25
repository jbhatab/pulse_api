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

PulseApi.Repo.insert!(%PulseApi.Room{name: "General"})
PulseApi.Repo.insert!(%PulseApi.Room{name: "Random"})