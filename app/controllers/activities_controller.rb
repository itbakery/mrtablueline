class ActivitiesController < ApplicationController
  layout 'content'
  before_filter  :log_hit, :only => [:show]
  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
    @announces = Announce.search(params[:search])
    @announces10 = Announce.desc(:created_at).limit(25).to_a
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activities = Activity.all.desc(:created_at).to_a
    @activity = Activity.find(params[:id])
    @announces = Announce.search(params[:search])
    @announces10 = Announce.desc(:created_at).limit(25).to_a
    @traffics = Effect.where(name: "Traffic").first.announces  rescue nil
    @sounds = Effect.where(name: "Sound").first.announces  rescue nil
    @vibrations = Effect.where(name: "Vibration").first.announces rescue nil
    @dusts = Effect.where(name: "Dust").first.announces rescue nil
    @drains = Effect.where(name: "Drain").first.announces rescue nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(params[:activity])

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
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
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
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
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end
  private
  def log_hit
    @userip = request.env['REMOTE_ADDR']
    @activity = Activity.find(params[:id])
    @activity.hits.create(user_ip: @userip)
  end

end
