Stateflow.persistence = :mongoid
class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  include Log
  default_scope where(state: :published)
  has_many :hits, as: :hitable, dependent: :destroy
  before_save :refresh_version
  before_update :refresh_version
  field :title, type: String
  field :intro, type: String
  field :content, type: String
  field :publishon, type: Date
  field :publishoff, type: Date
  field :approved, type: Boolean
  field :approvedby, type: String
  field :versions, type: String
  belongs_to :mediatype
  belongs_to :user
  field :issue_no, type: Date
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
  def hit_count
    hits.size
  end
  def unique_hit_count
    hits.group(:user_ip).size
  end

end
