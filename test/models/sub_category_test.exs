defmodule Jikken.SubCategoryTest do
  use Jikken.ModelCase

  alias Jikken.SubCategory

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SubCategory.changeset(%SubCategory{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SubCategory.changeset(%SubCategory{}, @invalid_attrs)
    refute changeset.valid?
  end
end
