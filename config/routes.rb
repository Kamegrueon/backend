Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace 'api' do
    namespace 'v1' do
      resources :games, defaults: {format: 'json'} do
        resources :dailies
        resources :players
        resources :game_rolls, only: :index
      end
      resources :dailies, defaults: {format: 'json'} do
        resources :cause_of_deaths, only: [:create]
        patch 'cause_of_deaths', to: 'cause_of_deaths#update'
      end
      get 'cause_of_deaths', to: 'cause_of_deaths#index'
      resources :votes, only: [:index, :create, :destroy]
      resources :coming_outs, only: [:index, :create, :edit] do 
        resources :ability_logs, only: [:create, :update, :destroy]
      end
      
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }

      namespace :auth do
        resources :sessions, only: [:index]
      end
    end
  end
end
