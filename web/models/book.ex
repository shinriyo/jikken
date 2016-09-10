defmodule Jikken.Book do
  use Jikken.Web, :model

  schema "books" do
    field :title, :string
    field :category, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :category])
    #|> validate_required([:title, :category])
  end
end
