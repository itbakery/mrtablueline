class Report
  include Mongoid::Document
  include Mongoid::Timestamps
  has_one :geopoint, as: :geoable, dependent: :destroy
  has_many :hits, as: :hitable, dependent: :destroy
  embeds_many :images, :cascade_callbacks => true
  accepts_nested_attributes_for :geopoint, :allow_destroy => true
  accepts_nested_attributes_for :images, :allow_destroy => true
  has_and_belongs_to_many :effects
  belongs_to :user
  belongs_to :station
  field :title, type: String
  field :content, type: String
  field :publishon, type: Date
  field :publishoff, type: Date
  field :approved, type: Boolean
  field :approvedby, type: String

  def hit_count
    hits.size
  end
  def unique_hit_count
    hits.group(:user_ip).size
  end
end
