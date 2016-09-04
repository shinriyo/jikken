defmodule Jikken.BookControllerTest do
  use Jikken.ConnCase

  alias Jikken.Book
  @valid_attrs %{publish: %{day: 17, month: 4, year: 2010}, title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, book_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    book = Repo.insert! %Book{}
    conn = get conn, book_path(conn, :show, book)
    assert json_response(conn, 200)["data"] == %{"id" => book.id,
      "title" => book.title,
      "publish" => book.publish,
      "sub_category_id" => book.sub_category_id,
      "author_id" => book.author_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, book_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, book_path(conn, :create), book: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Book, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, book_path(conn, :create), book: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    book = Repo.insert! %Book{}
    conn = put conn, book_path(conn, :update, book), book: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Book, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    book = Repo.insert! %Book{}
    conn = put conn, book_path(conn, :update, book), book: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    book = Repo.insert! %Book{}
    conn = delete conn, book_path(conn, :delete, book)
    assert response(conn, 204)
    refute Repo.get(Book, book.id)
  end
end
