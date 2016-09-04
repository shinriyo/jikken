defmodule Jikken.SubCategoryView do
  use Jikken.Web, :view

  def render("index.json", %{sub_categories: sub_categories}) do
    %{data: render_many(sub_categories, Jikken.SubCategoryView, "sub_category.json")}
  end

  def render("show.json", %{sub_category: sub_category}) do
    %{data: render_one(sub_category, Jikken.SubCategoryView, "sub_category.json")}
  end

  def render("sub_category.json", %{sub_category: sub_category}) do
    %{id: sub_category.id,
      category_id: sub_category.category_id,
      name: sub_category.name}
  end
end
