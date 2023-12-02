Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  # ERRORS
  match '/404', via: :all, to: 'errors#not_found'
  match '/500', via: :all, to: 'errors#internal_server_error'
  
  # USERS DEVISE
  devise_for :users
  # USERS NAMESPACE
  scope module: :users do
    authenticated :user do
      root to: redirect { |path_params, req| "/users/#{req.env['warden'].user(:user).id}" }, as: :authenticated_root
    end
    resources :users, only: [:show, :index] do
      resource :attributes, only: [:edit, :update]
      resource :photo, only: [ :edit, :update ]
    end
  end

  # BLOCKS NAMESPACE
  scope module: :blocks do
    # BLOCKS
    resources :users, only: [] do
      resources :blocks, except: [:index], shallow: true
    end

    resources :blocks, only: [] do
      put :order, on: :member
      # ITEMS
      resources :items, except: [:index], shallow: true do
        put :order, on: :member
      end
    end
    # ITEMS
    resources :item_contents, only: [:show, :edit, :update]
  end

  # BLOG
  resources :users, only: [] do
    resources :posts, shallow: true do
      patch :publish, on: :member
      put :order, on: :member
    end
  end

  # FILE UPLOADS
  resources :file_uploads, only: [:destroy]
  
  root to: 'pages#home'
end
