#custom routes for this plugin
ActionController::Routing::Routes.draw do |map|
  map.resources :iterations_history,:path_prefix => '/iterations/:id'
end
