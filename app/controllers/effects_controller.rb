class EffectsController < ApplicationController
  # GET /effects
  # GET /effects.json
  def index
    @effects = Effect.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @effects }
    end
  end

  # GET /effects/1
  # GET /effects/1.json
  def show
    @effect = Effect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @effect }
    end
  end

  # GET /effects/new
  # GET /effects/new.json
  def new
    @effect = Effect.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @effect }
    end
  end

  # GET /effects/1/edit
  def edit
    @effect = Effect.find(params[:id])
  end

  # POST /effects
  # POST /effects.json
  def create
    @effect = Effect.new(params[:effect])

    respond_to do |format|
      if @effect.save
        format.html { redirect_to @effect, notice: 'Effect was successfully created.' }
        format.json { render json: @effect, status: :created, location: @effect }
      else
        format.html { render action: "new" }
        format.json { render json: @effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /effects/1
  # PUT /effects/1.json
  def update
    @effect = Effect.find(params[:id])

    respond_to do |format|
      if @effect.update_attributes(params[:effect])
        format.html { redirect_to @effect, notice: 'Effect was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /effects/1
  # DELETE /effects/1.json
  def destroy
    @effect = Effect.find(params[:id])
    @effect.destroy

    respond_to do |format|
      format.html { redirect_to effects_url }
      format.json { head :no_content }
    end
  end
end
