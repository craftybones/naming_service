Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '', to: redirect('/interns')

  resources :interns do
    get 'search', :on => :collection
    get 'bulk-import', :on => :collection, :to => 'bulk_import'
    post 'bulk-import', :on => :collection, :to => 'interns#import'
  end

  resources :batches do

  end

  resources :users do

  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
