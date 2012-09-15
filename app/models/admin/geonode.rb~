class Admin::Geonode

  include Mongoid::Document
  include Gmaps4rails::ActsAsGmappable
  acts_as_gmappable :check_process => false

  field :name, type: String
  field :city, type: String
  field :country, type: String
  field :latitude, type: Float
  field :longitude, type: Float
  field :gmaps, type: Boolean

  def gmaps4rails_address
        "#{self.city}, #{self.country}"
  end
  attr_accessor :number

  def gmaps4rails_sidebar
    "#{name}"
  end


  before_save :update_location_coordinates
  protected

  def update_location_coordinates
    place = Gmaps4rails.geocode(gmaps4rails_address).first
    self.longitude, self.latitude = place[:lng], place[:lat] unless place.empty?
  rescue
    nil
  end
end
