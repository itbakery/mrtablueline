class Effect
  include Mongoid::Document
  field :name, type: String
  field :name_th, type: String
  field :description, type: String
  has_and_belongs_to_many :reports
  has_and_belongs_to_many :announces
  scope :effect_scope , lambda {|effect| where(name: effect)}
  def get_announcddes
    self.announces
  end
  def get_reports
    self.reports
  end
end
