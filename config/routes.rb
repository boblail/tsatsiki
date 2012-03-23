Tsatsiki::Application.routes.draw do
  
  devise_for :users
  
  root :to => 'home#index'
  
  resources :projects do
    resources :users, :controller => "project_users"
    resource :test_plan, :controller => "project_test_plan"
  end
  
  constraints :project_id => /\d+/, :index => /\d+/ do
    match '/projects/:project_id/specification' => 'project_specification#index', :via => :get, :as => :project_specification
    
    match '/projects/:project_id/features/*feature/new' => 'scenarios#new', :via => :get, :as => :new_scenario
    match '/projects/:project_id/features/*feature/:index/edit' => 'scenarios#edit', :via => :get, :as => :edit_scenario
    match '/projects/:project_id/features/*feature/:index' => 'scenarios#show', :via => :get, :as => :scenario
    match '/projects/:project_id/features/*feature/:index' => 'scenarios#update', :via => :put
    match '/projects/:project_id/features/*feature/:index' => 'scenarios#destroy', :via => :delete
    match '/projects/:project_id/features/*feature' => 'scenarios#create', :via => :post, :as => :scenarios, :format => false
    
    match '/projects/:project_id/features' => 'project_features#index', :via => :get, :as => :project_features
  end
  
end
