class Page
  include Mongoid::Document
  include Mongoid::Ancestry
  include Mongoid::Timestamps
  include Log
  before_update :refresh_version
  has_ancestry
  belongs_to :user
  field :title, type: String
  field :lang, type: String
  field :order, type: Integer, :default => 0
  field :content, type: String
  field :approved, type: Boolean
  field :versions, type: String
end
