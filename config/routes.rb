Cookinme::Application.routes.draw do
  get "oauths/oauth"
  get "oauths/callback"
  get "/" => "angular_app#index",
    as: "angular_app",
    constraints: LoggedInConstraint
  root to: "sessions#new"

  # Sessions and Sign up
  get "sign_in" => "sessions#new"
  post "sign_in" => "sessions#create"
  get "sign_up" => "users#new"
  post "sign_up" => "users#create"

  match "oauth/callback" => "oauths#callback", via: [:get, :post]
  match "oauth/:provider" => "oauths#oauth",
        :as => :auth_at_provider,
        via: [:get, :post]

  resources :passwords, only: [:new, :create, :edit, :update]

  # Resources accessed via JSON
  scope :api do
    get "cookbooks/all-recipes" => "smart_cookbooks#all_recipes"

    resources :cookbooks, except: [:new]

    resources :recipes, except: [:index, :new] do
      member do
        post :upload_photo
        delete :remove_photo
        put :update_cookbook
        delete :remove_cookbook
      end
    end

    resource :current_user, only: [:show, :update, :destroy] do
      member do
        post :upload_avatar
        delete :remove_avatar
      end
    end

    delete "sign_out" => "sessions#destroy"
  end
end
