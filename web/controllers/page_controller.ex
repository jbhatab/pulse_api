defmodule PulseApi.PageController do
  use PulseApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
