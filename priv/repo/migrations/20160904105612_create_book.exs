defmodule Jikken.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :publish, :date
      add :sub_category_id, references(:sub_categories, on_delete: :nothing)
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end
    create index(:books, [:sub_category_id])
    create index(:books, [:author_id])

  end
end
