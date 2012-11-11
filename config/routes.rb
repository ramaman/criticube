Criticube::Application.routes.draw do

  ActiveAdmin.routes(self)

  root :to => 'dashboard#home'
  get '/feed' => 'dashboard#feed', :as => 'dashboard_feed'
  get '/explore' => 'dashboard#explore', :as => 'explore'
  get '/explore/l/:language' => 'dashboard#explore', :as => 'explore_language'
  get '/explore/:topic_id' => 'dashboard#explore', :as => 'explore_topic'
  get '/explore/:topic_id/l/:language' => 'dashboard#explore', :as => 'explore_topic_language'
    
  ## USERS
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
  delete "/authentications/:provider" => 'authentications#destroy', :as => 'destroy_authentication'  
  post '/facebook/import_picture' => 'facebook#import_picture', :as => 'facebook_import_picture'
  get '/contact' => 'pages#contact', :to => 'pages#contact', :as => 'contact'
  get '/privacy' => 'pages#privacy', :to => 'pages#privacy', :as => 'privacy'  
  resources :users, :only => [:index]
  get '/users/:id' => 'users#old_show', :as => 'user_old_show'
  
  ## MESSAGES
  get '/messages' => 'messages#index', :as => 'messages'
  get '/messages/:user_id' => 'messages#conversation', :as => 'conversation'
  post '/messages' => 'messages#create', :as => 'messages'

  ## CUBES
  resources :cubes, :only => [:index, :new, :create]

  ## POSTS
  resources :posts, :only => [:create]

  ## TOPICS
  resources :topics, :only => :show
  post '/topics/:id/follow' => 'followages#follow', :as => 'topic_follow'
  delete '/topics/:vanity_id/unfollow' => 'followages#unfollow', :as => 'topic_unfollow'  
  
  ## FOLLOWAGES  
  resources :followages, :only => [:create, :destroy]
  
  ## NOTIFICATIONS
  delete '/notifications/read_all' => 'notifications#read_all', :as => 'read_all_notifications'
  resources :notifications, :only => [:index, :destroy]

  ## SEARCH
  get '/search', :as => 'search', :to => 'search#main'  
  post '/search', :as => 'search', :to => 'search#main'  

  ## FEEDBACK
  resources :feedbacks, :only => [:new, :create], :path => '/feedback'
  get '/feedback/problem', :to => 'feedbacks#problem', :as => 'feedback_problem'

  # Vanity level 1 and 2 are without named REST routing, but not after that (e.g. /replies/:id)

  get '/:id', :as => 'vanity', :to => proc { |env| vanity_controller(env, 'show') }
  get '/:id/edit', :as => 'edit_vanity', :to =>  proc { |env| vanity_controller(env, 'edit') }
  put '/:id', :as => 'vanity', :to => proc { |env| vanity_controller(env, 'update') }
  delete '/:id', :as => 'vanity', :to => proc { |env| vanity_controller(env, 'destroy') }
  get '/:vanity_id/following/:tipe', :as => 'vanity_following', :to => 'followages#following'
  get '/:vanity_id/followers', :as => 'vanity_followers', :to => 'followages#followers'
  get '/:vanity_id/activities', :as => 'vanity_activities', :to => 'activities#index'  
  get '/:vanity_id/posts', :as => 'vanity_posts', :to => 'posts#index'     
  get '/:vanity_id/admins', :as => 'vanity_admins', :to => 'cubes#admins'

  # Level 1 objects (User and Cube)

  post '/:vanity_id/follow' => 'followages#follow', :as => 'vanity_follow'
  delete '/:vanity_id/unfollow' => 'followages#unfollow', :as => 'vanity_unfollow'
  post '/:vanity_id/posts' => 'posts#create', :as => 'vanity_posts'

  get '/:vanity_id/:id' => 'posts#show', :as => 'vanity_post'
  get '/:vanity_id/:id/edit' => 'posts#edit', :as => 'edit_vanity_post'
  put '/:vanity_id/:id' => 'posts#update', :as => 'vanity_post'
  delete '/:vanity_id/:id' => 'posts#destroy', :as => 'vanity_post'

  post '/:vanity_id/:post_id/vote' => 'votes#vote', :as => 'vanity_post_vote'
  delete '/:vanity_id/:post_id/unvote' => 'votes#unvote', :as => 'vanity_post_unvote'
  post '/:vanity_id/:post_id/follow' => 'followages#follow', :as => 'vanity_post_follow'
  delete '/:vanity_id/:post_id/unfollow' => 'followages#unfollow', :as => 'vanity_post_unfollow'

  # Level 2 object (Post) and level 3 object (Reply)

  post '/:vanity_id/:post_id/replies' => 'replies#create', :as => 'vanity_post_replies'
  get '/:vanity_id/:post_id/replies/:id' => 'replies#show', :as => 'vanity_post_reply'
  # get '/:vanity_id/:post_id/replies/:id' => 'replies#update', :as => 'vanity_post_reply'
  # get '/:vanity_id/:post_id/replies/:id/edit' => 'replies#edit', :as => 'edit_vanity_post_reply'
  # put '/:vanity_id/:post_id/replies/:id' => 'replies#update', :as => 'vanity_post_reply'
  delete '/:vanity_id/:post_id/replies/:id' => 'replies#destroy', :as => 'vanity_post_reply'
  post '/:vanity_id/:post_id/replies/:reply_id/vote' => 'votes#vote', :as => 'vanity_post_reply_vote'
  delete '/:vanity_id/:post_id/replies/:reply_id/unvote' => 'votes#unvote', :as => 'vanity_post_reply_unvote'  

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
