RegionalRubykaigi::Application.routes.draw do
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/login' => 'sessions#new', :as => :login

  resource :session

  namespace :admin do
    resources :events do
      member do
        put :preview
      end
    end
    resources :events do
      resources :attendees
    end
    resources :users
  end

  match '/' => 'events#index'

  match ':name/:action' => 'events#show', :as => :event, :constraints => { :name => /[a-z]+\d+/ }

  match '/:controller(/:action(/:id))'
end
