class Hit
  include Mongoid::Document
  belongs_to :hitable  , polymorphic:  true
  field :user_ip, type: String
end
