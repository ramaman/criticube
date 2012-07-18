Criticube::Application.routes.draw do

  root :to => 'dashboard#home'
  
  devise_for :users, :path_names => {
    :sign_in => 'login', 
    :sign_out => 'logout', 
    :sign_up => 'signup'#,
    # :registration => 'account'
  } do  
    # post '/users' => 'registrations#create', :as => 'user_registration'
    # get '/settings' => 'registrations#edit', :as => 'user_registration'
    # put '/settings' => 'registrations#update', :as => 'user_registration'
    # delete '/settings' => 'registrations#destroy', :as => 'user_registration'

    
    # put '/:id' => 'registrations#update'
  end

  resources :users

  get "/:id" => "vanities#show", :as => 'profile'

end
