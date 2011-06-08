Tsatsiki::Application.routes.draw do
  
  root :to => redirect("/projects")
  
  resources :projects
  
  match '/projects/:project_id/features/*feature/:line' => 'scenarios#show', :via => :get
  
  mount WebsocketApp, :at => '/socket'
  
end
