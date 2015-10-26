defmodule PulseApi.RoomChannel do
  use Phoenix.Channel
  require Logger

  alias PulseApi.Message

  def join("rooms:lobby", message, socket) do
    Process.flag(:trap_exit, true)
    :timer.send_interval(5000, :ping)
    send(self, {:after_join, message})

    {:ok, socket}
  end

  def join("rooms:" <> _private_subtopic, _message, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info({:after_join, msg}, socket) do
    broadcast! socket, "user:entered", %{user: msg["user"]}
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end
  def handle_info(:ping, socket) do
    push socket, "new:msg", %{user: "SYSTEM", body: "ping"}
    {:noreply, socket}
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end

  def handle_in("new:msg", msg, socket) do
    message_params = %{body: msg["body"], room_id: msg["room_id"] }
    changeset = Message.changeset(%Message{}, message_params)

    case PulseApi.Repo.insert(changeset) do
      {:ok, room} ->
        broadcast! socket, "new:msg", %{user: msg["user"], body: msg["body"], room_id: msg["room_id"]}
        {:reply, {:ok, %{msg: msg["body"]}}, assign(socket, :user, msg["user"])}
      {:error, changeset} ->
    end
  end
end
