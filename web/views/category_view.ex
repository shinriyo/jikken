defmodule Jikken.CategoryView do
  use Jikken.Web, :view

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, Jikken.CategoryView, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, Jikken.CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{id: category.id,
      name: category.name}
  end
end
