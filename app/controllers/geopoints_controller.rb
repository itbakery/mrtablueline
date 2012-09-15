class GeopointsController < ApplicationController
  layout 'page'
  # GET /geopoints
  # GET /geopoints.json
  def index
    @geopoints = Geopoint.all
    @jsons = @geopoints.to_gmaps4rails
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @geopoints }
    end
  end

  # GET /geopoints/1
  # GET /geopoints/1.json
  def show
    @geopoint = Geopoint.find(params[:id])
    @json = @geopoint.to_gmaps4rails
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @geopoint }
    end
  end

  # GET /geopoints/new
  # GET /geopoints/new.json
  def new
    @geopoint = Geopoint.new
    @lat = 13.7522222
    @lng = 100.4938889
    @json = '[{"lng": "100.4938889", "lat": "13.7522222"}]'
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @geopoint }
    end
  end

  # GET /geopoints/1/edit
  def edit
    @geopoint = Geopoint.find(params[:id])
    @json = @geopoint.to_gmaps4rails
  end

  # POST /geopoints
  # POST /geopoints.json
  def create
    @geopoint = Geopoint.new(params[:geopoint])

    respond_to do |format|
      if @geopoint.save
        format.html { redirect_to @geopoint, notice: 'Geopoint was successfully created.' }
        format.json { render json: @geopoint, status: :created, location: @geopoint }
      else
        format.html { render action: "new" }
        format.json { render json: @geopoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /geopoints/1
  # PUT /geopoints/1.json
  def update
    @geopoint = Geopoint.find(params[:id])

    respond_to do |format|
      if @geopoint.update_attributes(params[:geopoint])
        format.html { redirect_to @geopoint, notice: 'Geopoint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @geopoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geopoints/1
  # DELETE /geopoints/1.json
  def destroy
    @geopoint = Geopoint.find(params[:id])
    @geopoint.destroy

    respond_to do |format|
      format.html { redirect_to geopoints_url }
      format.json { head :no_content }
    end
  end
end
