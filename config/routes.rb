Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :games,  defaults: {format: 'json'} do
        resources :dailies do
          resources :votes, only: [:create, :destroy]
        end
        resources :players
      end
    end
  end
end
