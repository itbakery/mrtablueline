class Geopoint
  include Mongoid::Document
  include Gmaps4rails::ActsAsGmappable
  acts_as_gmappable :check_process => false
  belongs_to :geoable , polymorphic: true
  field :name, type: String
  field :city, type: String
  field :country, type: String
  field :latitude, type: Float
  field :longitude, type: Float
  field :gmaps_zoom, type: Float
  field :gmaps, type: Boolean
  #def gmaps4rails_address
  #      "#{self.city}, #{self.country}"
  #end
  def gmaps4rails_address
      "#{self.latitude}, #{self.longitude}"
  end

  attr_accessor :number

  def gmaps4rails_sidebar
    "#{self.name} #{self.latitude} #{self.longitude}"
  end

  def gmaps4rails_infowindow
     @parentclass = self.geoable_type
     case @parentclass
     when "Station"
       @parentname = @parentclass.constantize.where(id: self.geoable_id).first.name
       @parentid = @parentclass.constantize.where(id: self.geoable_id).first.id
       @url = "station"
     when "Report"
       @parentname = @parentclass.constantize.where(id: self.geoable_id).first.title
       @parentid = @parentclass.constantize.where(id: self.geoable_id).first.id
       @url =  "report"
     end
     "<h4><a href='/progresses/#{@url}/#{@parentid}'>#{@parentname}</a> </h4> <br> #{self.name} <br> #{self.latitude} #{self.longitude}"
  end

  #protected

  #def update_location_coordinates
  #  place = Gmaps4rails.geocode(gmaps4rails_address).first
  #  self.longitude, self.latitude = place[:lng], place[:lat] unless place.empty?
  #rescue
  #  nil
  #end
end
