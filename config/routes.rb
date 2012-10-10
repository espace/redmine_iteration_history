#custom routes for this plugin
if Rails::VERSION::MAJOR >= 3
  RedmineApp::Application.routes.draw do
    scope '/iterations/:id' do
      resources :iterations_history
    end
    
    resources :subversions, :only => [:update], :as => "subversion_update"
  end
else
  ActionController::Routing::Routes.draw do |map|
    map.resources :iterations_history,:path_prefix => '/iterations/:id'
  end
end
