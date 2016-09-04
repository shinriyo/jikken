defmodule Jikken.AuthorView do
  use Jikken.Web, :view

  def render("index.json", %{authors: authors}) do
    %{data: render_many(authors, Jikken.AuthorView, "author.json")}
  end

  def render("show.json", %{author: author}) do
    %{data: render_one(author, Jikken.AuthorView, "author.json")}
  end

  def render("author.json", %{author: author}) do
    %{id: author.id,
      first_name: author.first_name,
      last_name: author.last_name}
  end
end
