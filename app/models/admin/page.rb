class Admin::Page
  include Mongoid::Document
  include Mongoid::Ancestry
  has_ancestry
  field :title, type: String
  field :permalink, type: String
  field :content, type: String
end
