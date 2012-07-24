Criticube::Application.routes.draw do

  root :to => 'dashboard#home'
  
  devise_for :users, :path_names => {
    :sign_in => 'login', 
    :sign_out => 'logout', 
    :sign_up => 'signup'#,
    # :registration => 'account'
    }, :controllers => { :omniauth_callbacks => "omniauth_callbacks" } do  
    # put '/settings' => 'registrations#update', :as => 'user_registration'
    # delete '/settings' => 'registrations#destroy', :as => 'user_registration'
    # put '/:id' => 'registrations#update'
    get '/signup/facebook' => 'registrations#new_from_facebook', :as => 'new_facebook_user_registration'
    post '/users' => 'registrations#create', :as => 'user_registration'
    post '/users/external' => 'registrations#create_with_omniauth', :as => 'omniauth_user_registration'
  end

  post '/facebook/import_picture' => 'facebook#import_picture', :as => 'facebook_import_picture'
  
  resources :users, :only => [:index, :show]

  delete "/authentications/:provider" => 'authentications#destroy', :as => 'destroy_authentication'

  get '/:id', :as => 'vanity', :to => proc { |env| vanity_controller(env, 'show') }
  get '/:id/edit', :as => 'edit_vanity', :to =>  proc { |env| vanity_controller(env, 'edit') }
  put '/:id', :as => 'vanity', :to => proc { |env| vanity_controller(env, 'update') }

  def vanity_controller(env, action)
    id = env["action_dispatch.request.path_parameters"][:id]
    vanity = Vanity.find(id) # rescue nil
    if vanity.nil?
      'application#404'
    else
      vanity_object = vanity.owner
      model = vanity_object.class.model_name
      controller = [model.pluralize.camelize,"Controller"].join.constantize
      env["action_dispatch.request.path_parameters"][:id] = vanity_object.id
      # do your internal redirect
      controller.action(action).call(env)
    end
  end

end
