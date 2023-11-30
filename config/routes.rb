Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  # ERRORS
  match '/404', via: :all, to: 'errors#not_found'
  match '/500', via: :all, to: 'errors#internal_server_error'
  
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
    # BLOCKS - Custom routes to avoid namespacing under users
    get 'users/:user_id/blocks/new', to: 'blocks#new', as: :new_user_block
    post 'users/:user_id/blocks', to: 'blocks#create', as: :user_blocks
    get 'users/:user_id/blocks/:id/edit', to: 'blocks#edit', as: :edit_user_block
    patch 'users/:user_id/blocks/:id', to: 'blocks#update', as: :user_block
    
    # BLOCKS
    resources :blocks, only: [:destroy] do
      # ITEMS
      resources :items, only: [:new, :create, :edit, :update]
    end

    # ITEMS
    resources :items, only: [:show, :destroy]
    resources :item_contents, only: [:show, :edit, :update]
  end

  # FILE UPLOADS
  resources :file_uploads, only: [:destroy]
  
  root to: 'pages#home'
end
