Criticube::Application.routes.draw do

  devise_for :users

  root :to => 'dashboard#home'  

end
