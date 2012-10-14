class SubversionsController < VersionsController
  before_filter :find_model_object
  before_filter :find_project_from_association
  before_filter :authorize
  before_filter :validate_change_reason_field, :only=>[:update]
  
  accept_api_auth :update

  helper :custom_fields
  helper :projects

  def validate_change_reason_field
    if !params[:old_date].blank? && params[:old_date]!=params[:version][:effective_date] && params[:version][:change_reason]==""
      flash[:error]="Please specify a reason for changing the due date."
      redirect_to :controller => 'versions', :action => 'edit'
    end 
  end

  def update
    @version = Version.find_by_id params[:id]
    if request.put? && params[:version]
      attributes = params[:version].dup
      if params[:old_date].blank? 
        attributes[:change_reason]='initial date'
      end
      attributes.delete('sharing') unless @version.allowed_sharings.include?(attributes['sharing'])
      @version.safe_attributes = attributes
      @version.change_reason = attributes[:change_reason] unless attributes[:change_reason].blank?
      if @version.save
        respond_to do |format|
          format.html {
            flash[:notice] = l(:notice_successful_update)
            redirect_to :controller => 'projects', :action => 'settings', :tab => 'versions', :id => @project
          }
          format.api  { render_api_ok }
        end
      else
        respond_to do |format|
          format.html { render :action => 'versions#edit' }
          format.api  { render_validation_errors(@version) }
        end
      end
    end
  end

private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
