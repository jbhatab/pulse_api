defmodule PulseApi.ChannelChannel do
  use Phoenix.Channel
  require Logger

  alias PulseApi.Message

  def join("channels:lobby", message, socket) do
    Process.flag(:trap_exit, true)
    send(self, {:after_join, message})

    {:ok, socket}
  end

  # def join("rooms:" <> room_name, params, socket) do    
  #   unless Repo.get_by(Room, name: room_name) do
  #     Repo.insert! %Room{name: room_name}
  #   end

  #   send(self, {:after_join, params})
  #   {:ok, RoomUsers.get_room(room_name), socket}
  # end

  # def join("rooms:" <> room_name, payload, socket) do
  #   payload = atomize_keys(payload)
  #   if authorized?(payload) do
  #     unless Repo.get_by(Room, name: room_name) do
  #       Repo.insert! %Room{name: room_name}
  #     end
  #     RoomActivityService.register(room: room_name, user: payload.user.name, pid: socket.channel_pid)
  #     send(self, %{event: "user:joined", new_user: payload.user.name})
  #     {:ok, RoomUsers.get_room(room_name), socket}
  #   else
  #     {:error, %{reason: "unauthorized"}}
  #   end
  # end

  def join("rooms:" <> _private_subtopic, _message, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info({:after_join, msg}, socket) do
    broadcast socket, "user:entered", %{user: msg["username"]}

    # push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end

  def handle_in("new:msg", msg, socket) do
    message_params = %{body: msg["body"], channel_id: msg["channel_id"] }
    changeset = Message.changeset(%Message{}, message_params)

    Logger.debug"Message params"
    Logger.debug"#{inspect msg}"
    Logger.debug"Message params"

    case PulseApi.Repo.insert(changeset) do
      {:ok, channel} ->
        broadcast socket, "new:msg", %{user: msg["user"], body: msg["body"], channel_id: msg["channel_id"]}
        {:reply, {:ok, %{msg: msg["body"]}}, assign(socket, :user, msg["user"])}
      {:error, changeset} ->
    end
  end

  def handle_in("change:username", user, socket) do
    broadcast socket, "user:set_username", %{username: user["username"]}

    {:noreply, socket}
  end
end
