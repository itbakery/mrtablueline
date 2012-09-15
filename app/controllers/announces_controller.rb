class AnnouncesController < ApplicationController
  # GET /announces
  # GET /announces.json
  def index
    @announces = Announce.all

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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @announce }
    end
  end

  # GET /announces/1/edit
  def edit
    @announce = Announce.find(params[:id])
  end

  # POST /announces
  # POST /announces.json
  def create
    @announce = Announce.new(params[:announce])

    respond_to do |format|
      if @announce.save
        format.html { redirect_to @announce, notice: 'Announce was successfully created.' }
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
    @announce = Announce.find(params[:id])

    respond_to do |format|
      if @announce.update_attributes(params[:announce])
        format.html { redirect_to @announce, notice: 'Announce was successfully updated.' }
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
      format.html { redirect_to announces_url }
      format.json { head :no_content }
    end
  end
end
