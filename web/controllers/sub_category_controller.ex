defmodule Jikken.SubCategoryController do
  use Jikken.Web, :controller

  alias Jikken.SubCategory

  def index(conn, _params) do
    sub_categories = Repo.all(SubCategory)
    render(conn, "index.json", sub_categories: sub_categories)
  end

  def create(conn, %{"sub_category" => sub_category_params}) do
    changeset = SubCategory.changeset(%SubCategory{}, sub_category_params)

    case Repo.insert(changeset) do
      {:ok, sub_category} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", sub_category_path(conn, :show, sub_category))
        |> render("show.json", sub_category: sub_category)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Jikken.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sub_category = Repo.get!(SubCategory, id)
    render(conn, "show.json", sub_category: sub_category)
  end

  def update(conn, %{"id" => id, "sub_category" => sub_category_params}) do
    sub_category = Repo.get!(SubCategory, id)
    changeset = SubCategory.changeset(sub_category, sub_category_params)

    case Repo.update(changeset) do
      {:ok, sub_category} ->
        render(conn, "show.json", sub_category: sub_category)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Jikken.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sub_category = Repo.get!(SubCategory, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sub_category)

    send_resp(conn, :no_content, "")
  end
end
