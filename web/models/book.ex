defmodule Jikken.Book do
  use Jikken.Web, :model

  schema "books" do
    field :title, :string
    field :publish, Ecto.Date
    belongs_to :sub_category, Jikken.SubCategory
    belongs_to :author, Jikken.Author

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :publish])
    # |> validate_required([:title, :publish])
  end
end
