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

  scope '/api' do
    get 'interns/search', :to => 'interns_api#search'
    get 'interns/filter', :to => 'interns_api#filter'
  end

  get 'api_token', :to => 'users#api_token'
  put 'regenerate_token', :to => 'users#regenerate_token'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
