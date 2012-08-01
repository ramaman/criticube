Criticube::Application.routes.draw do

  ActiveAdmin.routes(self)

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
  
  resources :users, :only => [:index]
  get '/users/:id' => 'users#old_show', :as => 'user_old_show'
  resources :cubes, :only => [:index, :new, :create]
  resources :followages, :only => [:create, :destroy]

  delete "/authentications/:provider" => 'authentications#destroy', :as => 'destroy_authentication'

  get '/search', :as => 'search', :to => 'search#main'
  post '/search', :as => 'search', :to => 'search#main'  

  # Vanity level 1 and 2 are without named REST routing, but not after that (e.g. /replies/:id)

  get '/:id', :as => 'vanity', :to => proc { |env| vanity_controller(env, 'show') }
  get '/:id/edit', :as => 'edit_vanity', :to =>  proc { |env| vanity_controller(env, 'edit') }
  put '/:id', :as => 'vanity', :to => proc { |env| vanity_controller(env, 'update') }
  delete '/:id', :as => 'vanity', :to => proc { |env| vanity_controller(env, 'destroy') }
  get '/:id/following/:tipe', :as => 'vanity_following', :to => 'followages#following'
  get '/:id/followers', :as => 'vanity_followers', :to => 'followages#followers'
  get '/:id/activities', :as => 'vanity_activities', :to => 'activities#index'  
  get '/:id/posts', :as => 'vanity_posts', :to => 'posts#index'     
  get '/:id/admins', :as => 'vanity_admins', :to => 'cubes#admins'

  post '/:vanity_id/posts' => 'posts#create', :as => 'vanity_posts'
  get '/:vanity_id/:id' => 'posts#show', :as => 'vanity_post'
  get '/:vanity_id/:id/edit' => 'posts#edit', :as => 'edit_vanity_post'
  put '/:vanity_id/:id' => 'posts#update', :as => 'vanity_post'
  delete '/:vanity_id/:id' => 'posts#destroy', :as => 'vanity_post'

  post '/:vanity_id/:post_id/replies' => 'replies#create', :as => 'vanity_post_replies'
  get '/:vanity_id/:post_id//replies/:id' => 'replies#show', :as => 'vanity_post_reply'
  # get '/:vanity_id/:post_id/replies/:id' => 'replies#update', :as => 'vanity_post_reply'
  # get '/:vanity_id/:post_id/replies/:id/edit' => 'replies#edit', :as => 'edit_vanity_post_reply'
  # put '/:vanity_id/:post_id/replies/:id' => 'replies#update', :as => 'vanity_post_reply'
  delete '/:vanity_id/:post_id/replies/:id' => 'replies#destroy', :as => 'vanity_post_reply'

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
