class Company
  include Mongoid::Document
  field :name_th, type: String
  field :name_en, type: String
  field :mission, type: String
  field :address, type: String
  field :tel, type: String
  field :contact, type: String
  field :telcontact, type: String
  field :callcenter, type: String
  mount_uploader :logo, LogoUploader
  has_many  :users
  validates :name_th, :presence => true
end
