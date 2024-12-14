Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  # ERRORS
  match '/404', via: :all, to: 'errors#not_found'
  match '/500', via: :all, to: 'errors#internal_server_error'

  root to: 'pages#home'

  # USERS DEVISE
  devise_for :users
  # USERS NAMESPACE
  scope module: :users do
    resources :users, only: %i[show index] do
      resource :attributes, only: %i[edit update] do
        put :save_content, on: :member
      end
      resource :photo, only: %i[edit update]
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
    resources :item_contents, only: %i[show edit update] do
      put :save_content, on: :member
      get 'photos/:photo_id', to: 'item_contents#show_photo', on: :member, as: :photo
      get :photos, on: :member
    end
    get 'photos/:photo_id', to: 'item_contents#photo_partial', as: :photo_partial
  end

  # BLOG
  resources :users, only: [] do
    resources :posts, shallow: true do
      patch :publish, on: :member
      post :shift, on: :member
      put :save_content, on: :member
    end
  end

  # FILE UPLOADS
  resources :file_uploads, only: [:destroy]

  # WORKER (Github Cronjob)
  get '/refresh_sitemap', to: 'worker#refresh_sitemap'
end
