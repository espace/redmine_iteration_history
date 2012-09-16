class VersionsController < ApplicationController
  before_filter :validate_change_reason_field,:only=>[:update]
  
  def validate_change_reason_field
#   if request.post?
     if !params[:old_date].blank? && params[:old_date]!=params[:version][:effective_date] && params[:version][:change_reason]==""
       flash[:error]="Please specify a reason for changing the due date."
       redirect_to :action=>'edit'
     end 
#   end
  end
end
