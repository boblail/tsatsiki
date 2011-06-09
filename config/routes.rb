Tsatsiki::Application.routes.draw do
  
  root :to => redirect("#{Rails.configuration.try(:relative_url_root)}/projects")
  
  resources :projects
  
  match '/projects/:project_id/features/*feature/:line' => 'scenarios#show', :via => :get
  
  mount WebsocketApp, :at => '/socket'
  
end
