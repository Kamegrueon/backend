Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :games, defaults: {format: 'json'} do
        resources :dailies
        resources :players
      end
      resources :dailies, defaults: {format: 'json'} do
        resources :cause_of_deaths, only: [:index, :create]
        patch 'cause_of_deaths', to: 'cause_of_deaths#update'
        resources :votes, only: [:create, :destroy]
      end
    end
  end
end
