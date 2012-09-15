Stateflow.persistence = :mongoid
class Announce
  include Mongoid::Document
  include Mongoid::Timestamps
  include Log
  has_one :geopoint, as: :geoable, dependent: :destroy
  has_many :hits, as: :hitable, dependent: :destroy
  accepts_nested_attributes_for :geopoint, :allow_destroy => true
  has_and_belongs_to_many :effects
  belongs_to :user
  before_save :refresh_version
  before_update :refresh_version
  field :title, type: String
  field :content, type: String
  field :publishon, type: Date
  field :publishoff, type: Date
  field :approved, type: Boolean
  field :approvedby, type: String
  field :versions, type: String
  field :state, type: String
  #State transisstions
  include  Stateflow
  stateflow do
    state_column :state
    initial   :unpublished
    state     :unpublished, :published, :archived
    event     :publish do
      transitions :from => :unpublished , :to => :published
    end
    event     :unpublish do
      transitions :from => :published, :to => :unpublished
      transitions :from => :archived, :to => :unpublished
    end
    event     :archive do
      transitions :from => :published, :to => :archived
    end
  end
  def self.search(search)
    if search
      where(title: /#{search}/)
    else
      all.desc(:created_at).to_a
    end
  end
  def hit_count
    hits.size
  end
  def unique_hit_count
    hits.group(:user_ip).size
  end

end
