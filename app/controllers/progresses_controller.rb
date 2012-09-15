class ProgressesController < ApplicationController
  layout 'progress'
  before_filter :log_hit, :only => [:report]
  before_filter :log_hit_announce, :only => [:announce]
  def index
    @stations = Station.all
    @station = Station.first
    @reports = @station.reports
  end

  def fullmap
    render :layout =>  'fullmap'
  end

  def show
    @stations = Station.all
    @station = Station.find(params[:id])
    @reports = @station.reports
  end
  def report
    @stations = Station.all
    @report = Report.find(params[:id])
    @station = Station.where(id: @report.station_id).first
  end
  def announce
    @announce = Announce.find(params[:id])
    @effects = Effect.all
  end

  def effect
    @effects = Effect.all
    if params[:id]
    @effect = Effect.find(params[:id])
    else
      @effect = Effect.first
    end
    @announces = @effect.announces
  end
  private
  def log_hit
    @userip = request.env['REMOTE_ADDR']
    @report = Report.find(params[:id])
    @report.hits.create(user_ip: @userip)
  end
  def log_hit_announce
    @userip = request.env['REMOTE_ADDR']
    @announce = Announce.find(params[:id])
    @announce.hits.create(user_ip: @userip)
  end

end

