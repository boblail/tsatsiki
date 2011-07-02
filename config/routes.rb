Tsatsiki::Application.routes.draw do
  
  root :to => redirect("#{Rails.configuration.try(:relative_url_root)}/projects")
  
  resources :projects
  
  match '/projects/:project_id/features/*feature/:index/edit' => 'scenarios#edit', :via => :get, :as => :edit_scenario
  match '/projects/:project_id/features/*feature/:index' => 'scenarios#show', :via => :get, :as => :scenario
  match '/projects/:project_id/features/*feature/:index' => 'scenarios#update', :via => :put
  
  mount WebsocketApp, :at => '/socket'
  
end
