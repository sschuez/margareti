Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  match '/404', via: :all, to: 'errors#not_found'
  match '/500', via: :all, to: 'errors#internal_server_error'
  
  root to: 'pages#home'
  
  # USERS
  devise_for :users
  scope module: :users do
    resources :users, path: "profile", only: [:show, :index] do
      resource :attributes, only: [:edit, :update]
      resource :photo, only: [ :edit, :update ]
    end
  end
end
