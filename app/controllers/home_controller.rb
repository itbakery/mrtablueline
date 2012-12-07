class HomeController < ApplicationController
  layout "home"
  def index
    @pageroots = Page.roots.asc(:order)
    @activities = Activity.all.desc(:created_at).to_a
    @pageactivities = Activity.where(approved: 1).desc(:created_at).page(params[:page]).per(5)
    @announces = Announce.where(approved: 1).search(params[:search])
    @announces10 = Announce.where(approved: 1).desc(:created_at).limit(25).to_a
    @traffics = Effect.where(approved: 1).effect_scope("Traffic").first.announces rescue nil
    @sounds = Effect.where(approved: 1).effect_scope("Sound").first.announces rescue nil
    @vibrations = Effect.where(approved: 1).scope("Vibration").first.announces rescue nil
    @dusts = Effect.where(approved: 1).scope("Dust").first.announces rescue nil
    @drains = Effect.where(approved: 1)scope("Drain").first.announces rescue nil
    @effects = Effect.all
    @reports = Report.all
    respond_to do |format|
      format.html
      format.js
    end
  end
  def mrtamap
    @json = '[{"lng": "100.5032", "lat": "13.7452"}]'

    @stations = Station.all
#    @station_jsons =  Geopoint.where(geoable_type: "Station").to_a.to_gmaps4rails
    @station_jsons =  Geopoint.where(geoable_type: "Station").to_a.to_gmaps4rails do |property,marker|
      marker.picture({
      "picture" => '/images/mrtastationicon.png',
     "width" =>  32,
     "height" => 37
      })
    end

    @announce_jsons = Geopoint.where(geoable_type: "Announce").to_a.to_gmaps4rails
    #@jsons = @announce_jsons
    #@jsons = @station_jsons
    @j = Geopoint.where(geoable_type: "Station").to_a <<  Geopoint.where(geoable_type: "Announce").to_a << Geopoint.where(geoable_type: "Report").to_a

    @jsons = @j.flatten.to_gmaps4rails
    #@json = [@marker1,@marker2].to_gmaps4rails
    respond_to do |format|
      format.html  {render :layout => "mapdisplay"}
    end
  end
  def underconstruction
    render :layout => "underconstruction"

  end
end
