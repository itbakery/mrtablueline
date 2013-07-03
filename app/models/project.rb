class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :tracks
  field :name, type: String
  field :startat, type: Date
  field :endat, type: Date
  field :description, type: String
end
