class VersionsHook < Redmine::Hook::ViewListener
  render_on :view_versions_edit_bottom, :partial => 'shared/due_date_change_reason'
  render_on :view_versions_show_bottom, :partial=>'shared/view_history'  
end