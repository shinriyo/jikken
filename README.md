# Jikken

SQLite

idつけた
```
mix phoenix.gen.json Category categories name:string
mix phoenix.gen.json Author authors first_name:string last_name:string
mix phoenix.gen.json SubCategory sub_categories category_id:references:categories name:string
mix phoenix.gen.json Book books title:string publish:date sub_category_id:references:sub_categories author_id:references:authors
```

```
mix phoenix.gen.json Category categories name:string
mix phoenix.gen.json Author authors first_name:string last_name:string
mix phoenix.gen.json SubCategory sub_categories category:references:categories name:string
mix phoenix.gen.json Book books title:string publish:date sub_category:references:sub_categories author:references:authors
```

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
