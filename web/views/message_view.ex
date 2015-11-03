defmodule PulseApi.MessageView do
  use PulseApi.Web, :view

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, PulseApi.MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    message
    %{id: message.id,
      body: message.body}
  end
end
