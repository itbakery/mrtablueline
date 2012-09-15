class Backoffice::MediatypesController < ApplicationController
  layout 'backoffice'

before_filter :authenticate_user!
load_and_authorize_resource
  # GET /mediatypes
  # GET /mediatypes.json
  def index
    @mediatypes = Mediatype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mediatypes }
    end
  end

  # GET /mediatypes/1
  # GET /mediatypes/1.json
  def show
    @mediatype = Mediatype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mediatype }
    end
  end

  # GET /mediatypes/new
  # GET /mediatypes/new.json
  def new
    @mediatype = Mediatype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mediatype }
    end
  end

  # GET /mediatypes/1/edit
  def edit
    @mediatype = Mediatype.find(params[:id])
  end

  # POST /mediatypes
  # POST /mediatypes.json
  def create
    @mediatype = Mediatype.new(params[:mediatype])

    respond_to do |format|
      if @mediatype.save
        format.html { redirect_to backoffice_mediatypes_path, notice: 'Mediatype was successfully created.' }
        format.json { render json: @mediatype, status: :created, location: @mediatype }
      else
        format.html { render action: "new" }
        format.json { render json: @mediatype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mediatypes/1
  # PUT /mediatypes/1.json
  def update
    @mediatype = Mediatype.find(params[:id])

    respond_to do |format|
      if @mediatype.update_attributes(params[:mediatype])
        format.html { redirect_to backoffice_mediatypes_path, notice: 'Mediatype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mediatype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mediatypes/1
  # DELETE /mediatypes/1.json
  def destroy
    @mediatype = Mediatype.find(params[:id])
    @mediatype.destroy

    respond_to do |format|
      format.html { redirect_to backoffice_mediatypes_url }
      format.json { head :no_content }
    end
  end

end
