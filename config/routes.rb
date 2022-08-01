Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :games, defaults: {format: 'json'} do
        resources :dailies
        resources :players
        resources :game_rolls, only: :index
      end
      resources :dailies, defaults: {format: 'json'} do
        resources :cause_of_deaths, only: [:index, :create]
        patch 'cause_of_deaths', to: 'cause_of_deaths#update'
      end
      resources :votes, only: [:index, :create, :destroy]
      resources :coming_outs, only: [:index, :create, :edit] do 
        resources :ability_logs, only: [:create, :update, :destroy]
      end
    end
  end
end
