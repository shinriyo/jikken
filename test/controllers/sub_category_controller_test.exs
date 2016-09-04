defmodule Jikken.SubCategoryControllerTest do
  use Jikken.ConnCase

  alias Jikken.SubCategory
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sub_category_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    sub_category = Repo.insert! %SubCategory{}
    conn = get conn, sub_category_path(conn, :show, sub_category)
    assert json_response(conn, 200)["data"] == %{"id" => sub_category.id,
      "category_id" => sub_category.category_id,
      "name" => sub_category.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, sub_category_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, sub_category_path(conn, :create), sub_category: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(SubCategory, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sub_category_path(conn, :create), sub_category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    sub_category = Repo.insert! %SubCategory{}
    conn = put conn, sub_category_path(conn, :update, sub_category), sub_category: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(SubCategory, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sub_category = Repo.insert! %SubCategory{}
    conn = put conn, sub_category_path(conn, :update, sub_category), sub_category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    sub_category = Repo.insert! %SubCategory{}
    conn = delete conn, sub_category_path(conn, :delete, sub_category)
    assert response(conn, 204)
    refute Repo.get(SubCategory, sub_category.id)
  end
end
