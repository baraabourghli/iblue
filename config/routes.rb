Rails.application.routes.draw do
  resources :patients
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount ActionCable.server, at: '/cable'

  get '/', to: 'patients#index'
  get '/about', to: 'patients#about'
  post 'add_new_patient' => 'patients#new_patient'
end
