class Station
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :reports
  has_one :geopoint, as: :geoable, dependent: :destroy
  accepts_nested_attributes_for :geopoint, :allow_destroy => true
  field :name, type: String
  field :content, type: String
  mount_uploader :mapicon, MapiconUploader
end
