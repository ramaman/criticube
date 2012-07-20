Criticube::Application.routes.draw do

  root :to => 'dashboard#home'
  
  devise_for :users, :path_names => {
    :sign_in => 'login', 
    :sign_out => 'logout', 
    :sign_up => 'signup'#,
    # :registration => 'account'
    }, :controllers => { :omniauth_callbacks => "omniauth_callbacks" } do  
    # get '/settings' => 'registrations#edit', :as => 'user_registration'
    # put '/settings' => 'registrations#update', :as => 'user_registration'
    # delete '/settings' => 'registrations#destroy', :as => 'user_registration'
    # put '/:id' => 'registrations#update'
    get '/signup/facebook' => 'registrations#new_from_facebook', :as => 'new_facebook_user_registration'
    post '/users' => 'registrations#create', :as => 'user_registration'
    post '/users/external' => 'registrations#create_with_omniauth', :as => 'omniauth_user_registration'
  end

  resources :users
  get "/:id" => "vanities#show", :as => 'profile'

end
