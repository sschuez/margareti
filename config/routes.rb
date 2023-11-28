Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  match '/404', via: :all, to: 'errors#not_found'
  match '/500', via: :all, to: 'errors#internal_server_error'
  
  # ROOTS
  
  # USERS
  devise_for :users
  scope module: :users do
    authenticated :user do
      root to: redirect { |path_params, req| "/users/#{req.env['warden'].user(:user).id}" }, as: :authenticated_root
    end
    resources :users, only: [:show, :index] do
      resource :attributes, only: [:edit, :update]
      resource :photo, only: [ :edit, :update ]
    end
  end

  # BLOCKS
  scope module: :blocks do
    # Custom route for 'new' that includes the user ID, but does not namespace under users
    get 'users/:user_id/blocks/new', to: 'blocks#new', as: :new_user_block
    # Standard non-nested routes for blocks
    resources :blocks, only: [:create, :destroy] do
      resources :items, only: [:new, :create, :show, :destroy]
    end
  end

  # FILE UPLOADS
  resources :file_uploads, only: [:destroy]
  
  root to: 'pages#home'
end
