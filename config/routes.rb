Tsatsiki::Application.routes.draw do
  
  root :to => 'home#index'
  
  resources :projects
  
  constraints :project_id => /\d+/, :index => /\d+/ do
    match '/projects/:project_id/features/*feature/new' => 'scenarios#new', :via => :get, :as => :new_scenario
    match '/projects/:project_id/features/*feature/:index/edit' => 'scenarios#edit', :via => :get, :as => :edit_scenario
    match '/projects/:project_id/features/*feature/:index' => 'scenarios#show', :via => :get, :as => :scenario
    match '/projects/:project_id/features/*feature/:index' => 'scenarios#update', :via => :put
    match '/projects/:project_id/features/*feature' => 'scenarios#create', :via => :post, :as => :scenarios, :format => false
  end
  
  mount WebsocketApp, :at => '/socket'
  
end
