class Backoffice::AnnouncesController < ApplicationController
  layout 'backoffice'
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /announces
  # GET /announces.json
  def index
    if (current_user.has_role? :admin) or (current_user.has_role? :mrtaadmin)
      @announces = Announce.all.desc(:created_at).to_a
    else
      @announces = current_user.announces.desc(:created_at).to_a
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @announces }
    end
  end

  # GET /announces/1
  # GET /announces/1.json
  def show
    @announce = Announce.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @announce }
    end
  end

  # GET /announces/new
  # GET /announces/new.json
  def new
    @announce = Announce.new
    @alleffects = Effect.all.to_a
    @selectedeffect = Effect.all.to_a.first
    @announce.build_geopoint
    @lat = 13.7522222
    @lng = 100.4938889
    @json = '[{"lng": "100.4938889", "lat": "13.7522222"}]'


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @announce }
    end
  end

  # GET /announces/1/edit
  def edit
    Announce.all!
    @announce = Announce.find(params[:id]) rescue nil
    @alleffects = Effect.all.to_a
    @json = @announce.geopoint.to_gmaps4rails
  end

  # POST /announces
  # POST /announces.json
  def create
    @announce = Announce.new(params[:announce])
    @announce.user_id = current_user._id

    respond_to do |format|
      if @announce.save
        ApproveSystem.perform_async(@announce.id,'announces','Announce')
        format.html { redirect_to backoffice_announces_path, notice: 'Announce was successfully created.' }
        format.json { render json: @announce, status: :created, location: @announce }
      else
        format.html { render action: "new" }
        format.json { render json: @announce.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /announces/1
  # PUT /announces/1.json
  def update
    @announce = Announce.unscoped.find(params[:id])

    respond_to do |format|
      if @announce.update_attributes(params[:announce])
        format.html { redirect_to backoffice_announces_path, notice: 'Announce was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @announce.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announces/1
  # DELETE /announces/1.json
  def destroy
    @announce = Announce.find(params[:id])
    @announce.destroy

    respond_to do |format|
      format.html { redirect_to backoffice_announces_url }
      format.json { head :no_content }
    end
  end
  def approve
    @announce = Announce.find(params[:id])
    if @announce.approved
       @announce.approved = false
    @announce.approvedby= "unapproved #{current_user.name || current_user.email}"  + Time.now.strftime("on %m/%d/%Y at %I:%M%p")
    else
       @announce.approved = true
       @announce.approvedby= "approved #{current_user.name || current_user.email}"  + Time.now.strftime("on %m/%d/%Y at %I:%M%p")

    end

    @announce.save
    respond_to do |format|
      format.html { redirect_to backoffice_announces_path }
    end
  end
end
