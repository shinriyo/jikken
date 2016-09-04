defmodule Jikken.Router do
  use Jikken.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Jikken do
    pipe_through :browser # Use the default browser stack

    # get "/book_create", BookController, :new
    get "/api/authors/get_author_number", AuthorController, :get_author_number
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Jikken do
    #  get "/authors/get_author_number", AuthorController, :get_author_number
      # resources "/books", BookController, except: [:new, :edit]
      resources "/categories", CategoryController, except: [:new, :edit]
      resources "/books", BookController, except: [:new, :edit]
      resources "/sub_categories", SubCategoryController, except: [:new, :edit]
      resources "/authors", AuthorController, except: [:new, :edit]
  #   pipe_through :api
  end
end
