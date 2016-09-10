defmodule Jikken.BookView do
  use Jikken.Web, :view

  def render("index.json", %{books: books}) do
    %{data: render_many(books, Jikken.BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, Jikken.BookView, "book.json")}
  end

  def render("book.json", %{book: book}) do
    %{id: book.id,
      title: book.title,
      category: book.category}
  end
end
