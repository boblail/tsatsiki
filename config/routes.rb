Tsatsiki::Application.routes.draw do
  
  resources :projects
  
  mount WebsocketApp, :at => '/socket'
  
end
