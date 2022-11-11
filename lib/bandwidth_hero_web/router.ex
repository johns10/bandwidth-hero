defmodule BandwidthHeroWeb.Router do
  use BandwidthHeroWeb, :router

  import BandwidthHeroWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BandwidthHeroWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug :set_color_scheme
  end

  defp set_color_scheme(conn, _opts) do
    color_scheme = conn.cookies["color-scheme"] || "dark"

    conn
    |> assign(:color_scheme, color_scheme)
    |> put_session(:color_scheme, color_scheme)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BandwidthHeroWeb do
    pipe_through :browser

    live "/", ProfileLive.Show, :show
    live "/profile", ProfileLive.Show, :show
    live "/profile/new_contractor", ProfileLive.Show, :new_contractor
    live "/profile/new_sourcer", ProfileLive.Show, :new_sourcer
  end

  # Other scopes may use custom stacks.
  # scope "/api", BandwidthHeroWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/", BandwidthHeroWeb do
      pipe_through :browser
      live "/live", PageLive, :index
      live "/live/modal/:size", PageLive, :modal
      live "/live/slide_over/:origin", PageLive, :slide_over
      live "/live/pagination/:page", PageLive, :pagination

      live "/erp_tag", ErpTagLive.Index, :index
      live "/erp_tag/new", ErpTagLive.Index, :new
      live "/erp_tag/:id/edit", ErpTagLive.Index, :edit

      live "/erp_tag/:id", ErpTagLive.Show, :show
      live "/erp_tag/:id/show/edit", ErpTagLive.Show, :edit

      live "/experience", ExperienceLive.Index, :index
      live "/experience/new", ExperienceLive.Index, :new
      live "/experience/:id/edit", ExperienceLive.Index, :edit

      live "/experience/:id", ExperienceLive.Show, :show
      live "/experience/:id/show/edit", ExperienceLive.Show, :edit

      live "/certificate", CertificateLive.Index, :index
      live "/certificate/new", CertificateLive.Index, :new
      live "/certificate/:id/edit", CertificateLive.Index, :edit

      live "/certificate/:id", CertificateLive.Show, :show
      live "/certificate/:id/show/edit", CertificateLive.Show, :edit

      live "/contractor", ContractorLive.Index, :index
      live "/contractor/new", ContractorLive.Index, :new
      live "/contractor/:id/edit", ContractorLive.Index, :edit

      live "/contractor/:id", ContractorLive.Show, :show
      live "/contractor/:id/show/edit", ContractorLive.Show, :edit

      live "/contractor/:id/erp_tag/new", ContractorLive.Show, :new_erp_tag
      live "/contractor/:id/erp_tag/:erp_tag_id/edit", ContractorLive.Show, :edit_erp_tag

      live "/contractor/:id/availability/new", ContractorLive.Show, :new_availability

      live "/contractor/:id/availability/:availability_id/edit",
           ContractorLive.Show,
           :edit_availability

      live "/contractor_erp_tag", ContractorErpTagLive.Index, :index
      live "/contractor_erp_tag/new", ContractorErpTagLive.Index, :new
      live "/contractor_erp_tag/:id/edit", ContractorErpTagLive.Index, :edit

      live "/contractor_erp_tag/:id", ContractorErpTagLive.Show, :show
      live "/contractor_erp_tag/:id/show/edit", ContractorErpTagLive.Show, :edit

      live "/availability", AvailabilityLive.Index, :index
      live "/availability/new", AvailabilityLive.Index, :new
      live "/availability/:id/edit", AvailabilityLive.Index, :edit

      live "/availability/:id", AvailabilityLive.Show, :show
      live "/availability/:id/show/edit", AvailabilityLive.Show, :edit

      live "/sourcers", SourcerLive.Index, :index
      live "/sourcers/new", SourcerLive.Index, :new
      live "/sourcers/:id/edit", SourcerLive.Index, :edit

      live "/sourcers/:id", SourcerLive.Show, :show
      live "/sourcers/:id/show/edit", SourcerLive.Show, :edit

      live "/sourcers/:id/show/new_opportunity", SourcerLive.Show, :new_opportunity
      live "/sourcers/:id/show/:opportunity_id/edit", SourcerLive.Show, :edit_opportunity

      live "/sourcer_users", SourcerUserLive.Index, :index
      live "/sourcer_users/new", SourcerUserLive.Index, :new
      live "/sourcer_users/:id/edit", SourcerUserLive.Index, :edit

      live "/sourcer_users/:id", SourcerUserLive.Show, :show
      live "/sourcer_users/:id/show/edit", SourcerUserLive.Show, :edit

      live "/opportunities", OpportunityLive.Index, :index
      live "/opportunities/new", OpportunityLive.Index, :new
      live "/opportunities/:id/edit", OpportunityLive.Index, :edit

      live "/opportunities/:id", OpportunityLive.Show, :show
      live "/opportunities/:id/show/edit", OpportunityLive.Show, :edit

      live "/opportunity_erp_tags", OpportunityErpTagLive.Index, :index
      live "/opportunity_erp_tags/new", OpportunityErpTagLive.Index, :new
      live "/opportunity_erp_tags/:id/edit", OpportunityErpTagLive.Index, :edit

      live "/opportunity_erp_tags/:id", OpportunityErpTagLive.Show, :show
      live "/opportunity_erp_tags/:id/show/edit", OpportunityErpTagLive.Show, :edit
    end

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BandwidthHeroWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", BandwidthHeroWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", BandwidthHeroWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", BandwidthHeroWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
