defmodule Newton.Helpers do
  import Plug.Conn

  def text(conn, data) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, data)
  end

  def json(conn, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode_to_iodata!(data))
  end

  def html(conn, data) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, data)
  end
end
