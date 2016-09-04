defmodule Jikken.SubCategory do
  use Jikken.Web, :model

  schema "sub_categories" do
    field :name, :string
    belongs_to :category, Jikken.Category

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    # |> validate_required([:name])
  end
end
