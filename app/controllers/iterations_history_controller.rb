class IterationsHistoryController < ApplicationController
  before_filter :find_version
  before_filter :authorize
  def index
    @due_history=@version.iteration_histories
  end
  
  private
  def find_version
    @version = Version.find(params[:id])
    @project = @version.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end