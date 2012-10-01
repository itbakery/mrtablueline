class HomeController < ApplicationController
  layout "home"
  def index
    @pageroots = Page.roots.asc(:order)
    @activities = Activity.all.desc(:created_at).to_a
    @announces = Announce.search(params[:search])
    @announces10 = Announce.limit(10).to_a
    @traffics = Effect.effect_scope("Traffic").first.announces rescue nil
    @sounds = Effect.effect_scope("Sound").first.announces rescue nil
    @vibrations = Effect.scope("Vibration").first.announces rescue nil
    @dusts = Effect.scope("Dust").first.announces rescue nil
    @drains = Effect.scope("Drain").first.announces rescue nil
    @effects = Effect.all
    @reports = Report.all
    respond_to do |format|
      format.html
      format.js
    end
  end
  def mrtamap
    @json = '[{"lng": "100.4938889", "lat": "13.7522222"}]'

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
    @jsons = @station_jsons
    respond_to do |format|
      format.html  {render :layout => "mapdisplay"}
    end
  end
  def underconstruction
    render :layout => "underconstruction"

  end
end
