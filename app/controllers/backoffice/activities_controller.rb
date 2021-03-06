class Backoffice::ActivitiesController < ApplicationController
  layout 'backoffice'
  before_filter :authenticate_user!
  load_and_authorize_resource
    # GET /activities
  # GET /activities.json
  def index
    if (current_user.has_role? :admin) or (current_user.has_role? :mrtaadmin)
      @activities = Activity.unscoped.all.desc(:created_at).to_a
    else
      @activities = current_user.activities.unscoped.desc(:created_at).to_a

    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show

    if (current_user.has_role? :admin) or (current_user.has_role? :mrtaadmin)
      @activity = Activity.find(params[:id])
    else
      @activity = current_user.activities.find(params[:id])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new
    @allmedias = Mediatype.all
    @selectedmedia = Mediatype.all.to_a.first
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
    @allmedias = Mediatype.all
    @selectedmedia = @activity.mediatype
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(params[:activity])
    @activity.user_id = current_user._id
    respond_to do |format|
      if @activity.save
        ApproveSystem.perform_async(@activity.id,'activities','Activity')
        format.html { redirect_to backoffice_activities_path, notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to backoffice_activities_path, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to backoffice_activities_url }
      format.json { head :no_content }
    end
  end
  def approve
    @activity = Activity.find(params[:id])
    if @activity.approved
       @activity.approved = false
    @activity.approvedby= "unapproved #{current_user.name || current_user.email}"  + Time.now.strftime("on %m/%d/%Y at %I:%M%p")
    else
       @activity.approved = true
       @activity.approvedby= "approved #{current_user.name || current_user.email}"  + Time.now.strftime("on %m/%d/%Y at %I:%M%p")

    end

    @activity.save
    respond_to do |format|
      format.html { redirect_to backoffice_activities_path }
    end
  end

end
