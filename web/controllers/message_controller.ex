defmodule PulseApi.MessageController do
  use PulseApi.Web, :controller
  require Logger

  alias PulseApi.Message

  def index(conn, params) do
    messages = Message  
    |> Message.by_channel(params["channel_id"])
    |> PulseApi.Repo.all

    render(conn, "index.json", messages: messages)
  end
end
