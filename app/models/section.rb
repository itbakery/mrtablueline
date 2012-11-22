class Section
  include Mongoid::Document
  field :name, type: String
  has_many :stations, :dependent => :destroy
end
