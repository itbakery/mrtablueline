class Mrta::ProjectsController < ApplicationController
  layout 'project'
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to [:mrta,@project], notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to [:mrta,@project], notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to mrta_projects_url }
      format.json { head :no_content }
    end
  end

  def gentracks
    @project = Project.find(params[:id])
    @startat = @project.startat
    @endat   = @project.endat
    @months = beginning_of_month_date_list(@startat,@endat)
    @months.each do  |month|
        unless ( @project.tracks.map(&:atmonth).include? month)
          @project.tracks.push(Track.new(atmonth: month))
        end
    end
    @project.save
    respond_to do |format|
      format.js
    end
  end
  def showtracks
    @project = Project.find(params[:id])
    @tracks = @project.tracks.order_by(atmonth: :asc)
    respond_to do |format|
      format.html
    end
  end

  def beginning_of_month_date_list(start, finish)
    (start..finish).map(&:beginning_of_month).uniq.map(&:to_s)
  end
end
