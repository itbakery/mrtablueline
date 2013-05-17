class ProgressesController < ApplicationController
  layout 'progress'
  before_filter :log_hit, :only => [:report]
  before_filter :log_hit_announce, :only => [:announce]
  def index
    @stations = Station.all
    @station = Station.first
    @reports = @station.reports.where(approved: 1).desc(:created_at)
    @effects = Effect.all
    @sections = Section.all
    @announces10 = Announce.where(approved: 1).desc(:created_at).limit(25).to_a
  end
  def report_latest
    @stations = Station.all
    @station = Station.first
    @reports = Report.where(approved: 1).all.desc(:created_at)
    @effects = Effect.all
    @sections = Section.all
    @announces10 = Announce.where(approved: 1).desc(:created_at).limit(25).to_a
  end
  def report_monthly
    @stations = Station.all
    @station = Station.first
    @reports = Report.where(approved: 1).all.desc(:created_at).page(params[:page]).per(10)
    @effects = Effect.all
    @sections = Section.all
    @announces10 = Announce.where(approved: 1).desc(:created_at).limit(25).to_a
  end
  def activity
    @stations = Station.all
    @station = Station.first
    @activities = Activity.where(approved: 1).all.desc(:created_at)
    @effects = Effect.all
    @sections = Section.all
    @announces10 = Announce.desc(:created_at).limit(25).to_a
  end
  def activity_latest
    @stations = Station.all
    @station = Station.first
    @activities = Activity.where(approved: 1).all.desc(:created_at)
    @effects = Effect.all
    @sections = Section.all
    @announces10 = Announce.desc(:created_at).limit(25).to_a
  end
  def activity_monthly
    @stations = Station.all
    @station = Station.first
    @activities = Activity.where(approved: 1).all.desc(:created_at)
    @effects = Effect.all
    @sections = Section.all
    @announces10 = Announce.desc(:created_at).limit(25).to_a
  end

  def fullmap
    render :layout =>  'fullmap'
  end

  def show
    @stations = Station.all
    @station = Station.find(params[:id])
    @reports = @station.reports.where(approved: 1).desc(:created_at)
    @effects = Effect.all
    @sections = Section.all
  end
  def report
    @stations = Station.all
    @report = Report.find(params[:id])
    @station = Station.where(id: @report.station_id).first
    @effects = Effect.all
    @sections = Section.all
    @announces10 = Announce.desc(:created_at).limit(25).to_a
  end
  def announce
    @announce = Announce.find(params[:id])
    @effects = Effect.all
    @effects = Effect.all
    @announces10 = Announce.desc(:created_at).limit(25).to_a
    @sections = Section.all
  end

  def effect
    @effects = Effect.all
    if params[:id]
      @effect = Effect.find(params[:id])
    else
      @effect = Effect.first
    end
    @announces = @effect.announces
    @sections = Section.all
    @announces10 = Announce.desc(:created_at).limit(25).to_a
  end
  def effect_latest
    @effects = Effect.all
    if params[:id]
      @effect = Effect.find(params[:id])
    else
      @effect = Effect.first
    end
    @announces = @effect.announces.desc(:created_at)
    @sections = Section.all
    @announces10 = Announce.desc(:created_at).limit(25).to_a
  end
  def effect_monthly
    @effects = Effect.all
    if params[:id]
      @effect = Effect.find(params[:id])
    else
      @effect = Effect.first
    end
    @announces = @effect.announces.desc(:created_at)
    @sections = Section.all
    @announces10 = Announce.desc(:created_at).limit(25).to_a
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

