defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HelloWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug :accepts, ["json"]
    plug HelloWeb.JWTAuthPlug
  end

  scope "/", HelloWeb do
    pipe_through :api

    post "/register", AuthController, :register
    post "/login", AuthController, :login
    get "/blog", PostController, :index
    get "/blog/:id", PostController, :show
  end

  scope "/api/v1", HelloWeb do
    pipe_through :auth

    get "/", AuthController, :get
    delete "/", AuthController, :logout
    get "/ping", AuthController, :ping

    scope "/blog" do
      post "/", PostController, :create
      put "/:id", PostController, :update
      delete "/:id", PostController, :delete
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:hello, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HelloWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
