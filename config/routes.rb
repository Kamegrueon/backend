Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :games, defaults: {format: 'json'} do
        resources :dailies
        resources :players
      end
      resources :dailies, defaults: {format: 'json'} do
        resources :daily_reports, only: :create
        get 'daily_report', to: 'daily_reports#show'
        put 'daily_report', to: 'daily_reports#update'
        resources :votes, only: [:create, :destroy]
      end
    end
  end
end
