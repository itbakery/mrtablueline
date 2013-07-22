class Mrta::GraphsController < ApplicationController
  layout 'project'
  def index
    if params[:id]
        @project = Project.find(params[:id])
    else
        @project = Project.first
    end
  end

end
