# Jikken

SQLite

```
mix phoenix.gen.json Book books title:string category:string 
```

テスト

GET
```
curl -v -H "Accept: application/json" -H "Content-type: application/json" http://localhost:4000/api/books
```

POST
```
curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"book": {"title": "タイトル", "category": "内容" }}' http://localhost:4000/api/books
```

AuthorConrtoller
```
  def get_author_number(conn, _params) do
    authors = Repo.all(Author)
    text(conn, length(authors))
  end
```

 open  priv/repo/migrations/
  
To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
