Rails.application.routes.draw do
  # devise_for :users
  namespace :api, defaults:{ format: :json } do
    namespace :v1 do
      resources :sessions, :only => [:create, :destroy]
      resources :users, :only => [:show, :create, :index, :update, :destroy]
    end
  end
end
