defmodule Jikken.Book do
  use Jikken.Web, :model

  schema "books" do
    field :title, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    # |> validate_required([:title])
  end
end
