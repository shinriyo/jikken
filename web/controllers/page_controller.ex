defmodule Jikken.PageController do
  use Jikken.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
