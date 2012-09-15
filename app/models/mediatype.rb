class Mediatype
  include Mongoid::Document
  field :name_th, type: String
  field :name_en, type: String
  mount_uploader :medialogo, MedialogoUploader
  has_many :Activities , :dependent => :destroy
  validates :name_th, :presence => true
end
