class Profile
  include Mongoid::Document
  field :name_th, type: String
  field :name_en, type: String
  field :position, type: String
  field :mobile, type: String
  mount_uploader :avatar,  AvatarUploader
  belongs_to :user
end
