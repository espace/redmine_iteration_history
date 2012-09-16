require 'redmine'
require 'dispatcher'
require_dependency 'versions_hook'

Dispatcher.to_prepare do
  require_dependency 'version'
  require 'version_patch'
  Version.send( :include, VersionPatch)
end

Redmine::Plugin.register :redmine_iteration_history do
  name 'Redmine Iteration History plugin'
  author 'Basayel Said'
  description 'Any team member would be able to see the history of the due date changes for any iteration'
  version '0.0.1'
  
  project_module :iterations_tracking do
    permission :view_iteration_due_history, {:iterations_history => [:index]} ,:require => :member  
  end
end
