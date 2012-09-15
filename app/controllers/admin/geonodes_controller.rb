class Admin::GeonodesController < ApplicationController
  # GET /admin/geonodes
  # GET /admin/geonodes.json
  def index
    @admin_geonodes = Admin::Geonode.all
    @admin_geonodes.each_with_index do |geonode,index|
        geonode.number = index
    end
    @jsons = @admin_geonodes.to_gmaps4rails
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_geonodes }
    end
  end

  # GET /admin/geonodes/1
  # GET /admin/geonodes/1.json
  def show
    @admin_geonode = Admin::Geonode.find(params[:id])
    @json = @admin_geonode.to_gmaps4rails
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_geonode }
    end
  end

  # GET /admin/geonodes/new
  # GET /admin/geonodes/new.json
  def new
    @admin_geonode = Admin::Geonode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_geonode }
    end
  end

  # GET /admin/geonodes/1/edit
  def edit
    @admin_geonode = Admin::Geonode.find(params[:id])
    @json = @admin_geonode.to_gmaps4rails
  end

  # POST /admin/geonodes
  # POST /admin/geonodes.json
  def create
    @admin_geonode = Admin::Geonode.new(params[:admin_geonode])

    respond_to do |format|
      if @admin_geonode.save
        format.html { redirect_to @admin_geonode, notice: 'Geonode was successfully created.' }
        format.json { render json: @admin_geonode, status: :created, location: @admin_geonode }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_geonode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/geonodes/1
  # PUT /admin/geonodes/1.json
  def update
    @admin_geonode = Admin::Geonode.find(params[:id])

    respond_to do |format|
      if @admin_geonode.update_attributes(params[:admin_geonode])
        format.html { redirect_to @admin_geonode, notice: 'Geonode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_geonode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/geonodes/1
  # DELETE /admin/geonodes/1.json
  def destroy
    @admin_geonode = Admin::Geonode.find(params[:id])
    @admin_geonode.destroy

    respond_to do |format|
      format.html { redirect_to admin_geonodes_url }
      format.json { head :no_content }
    end
  end
end
