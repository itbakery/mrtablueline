class Backoffice::StationsController < ApplicationController
  # GET /stations
  # GET /stations.json
  layout "backoffice"
  before_filter :authenticate_user!
  def index

    @stations = Station.page(params[:page]).per(15)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stations }
    end
  end

  # GET /stations/1
  # GET /stations/1.json
  def show
    @station = Station.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @station }
    end
  end

  # GET /stations/new
  # GET /stations/new.json
  def new
    @station = Station.new
    @station.build_geopoint
    @lat = 13.7522222
    @lng = 100.4938889
    @sections = Section.all
    @section = Section.all.to_a.first
    @json = '[{"lng": "100.4938889", "lat": "13.7522222"}]'
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @station }
    end
  end

  # GET /stations/1/edit
  def edit
    @station = Station.find(params[:id])
     @json = @station.geopoint.to_gmaps4rails
    @sections = Section.all
    @section = @station.section
  end

  # POST /stations
  # POST /stations.json
  def create
    @station = Station.new(params[:station])
    respond_to do |format|
      if @station.save
        format.html { redirect_to backoffice_stations_path, notice: 'Station was successfully created.' }
        format.json { render json: @station, status: :created, location: @station }
      else
        format.html { render action: "new" }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stations/1
  # PUT /stations/1.json
  def update
    @station = Station.find(params[:id])

    respond_to do |format|
      if @station.update_attributes(params[:station])
        format.html { redirect_to backoffice_stations_path, notice: 'Station was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stations/1
  # DELETE /stations/1.json
  def destroy
    @station = Station.find(params[:id])
    @station.destroy

    respond_to do |format|
      format.html { redirect_to backoffice_stations_url }
      format.json { head :no_content }
    end
  end

end
