class Backoffice::ReportsController < ApplicationController
  layout 'backoffice'
  before_filter :authenticate_user!
  load_and_authorize_resource
  def index
    if (current_user.has_role? :admin) or (current_user.has_role? :mrtaadmin)
      @reports = Report.all.desc(:created_at).to_a
    else
      current_user.reports.desc(:created_at).to_a
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reports/new
  # GET /reports/new.json
  def new
    @report = Report.new
    @report.build_geopoint
    @lat = 13.7522222
    @lng = 100.4938889
    @json = '[{"lng": "100.4938889", "lat": "13.7522222"}]'
    @allstations = Station.all
    @selectedstation = Station.all.to_a.first

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reports/1/edit
  def edit
    @report = Report.find(params[:id])
    @json = @report.geopoint.to_gmaps4rails
    @allstations = Station.all
    @selectedstation = @report.station

  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(params[:report])
    @report.user_id = current_user._id
    respond_to do |format|
      if @report.save
        ApproveSystem.perform_async(@report.id,'reports','Report')
        format.html { redirect_to backoffice_reports_path, notice: 'Report was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.json
  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to backoffice_reports_path, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to backoffice_reports_url }
      format.json { head :no_content }
    end
  end
  def show_map

  end
  def approve
    @report = Report.find(params[:id])
    if @report.approved
       @report.approved = false
    @report.approvedby= "unapproved #{current_user.name || current_user.email}"  + Time.now.strftime("on %m/%d/%Y at %I:%M%p")
    else
       @report.approved = true
       @report.approvedby= "approved #{current_user.name || current_user.email}"  + Time.now.strftime("on %m/%d/%Y at %I:%M%p")

    end

    @report.save
    respond_to do |format|
      format.html { redirect_to backoffice_reports_path }
    end
  end

end
