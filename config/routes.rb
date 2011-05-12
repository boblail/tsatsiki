Tsatsiki::Application.routes.draw do
  
  root :to => redirect("/projects")
  
  resources :projects
  
  mount WebsocketApp, :at => '/socket'
  
end
