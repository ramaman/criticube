Criticube::Application.routes.draw do

  root :to => 'dashboard#home'
  
  devise_for :users, :path => '', :path_names => {
    :sign_in => 'login', 
    :sign_out => 'logout', 
    :sign_up => 'signup',
  } do  
    post '/users' => 'registrations#create', :as => 'user_registration'   
  end

  resources :users

  get "/:id" => "vanities#show", :as => 'profile'

end
