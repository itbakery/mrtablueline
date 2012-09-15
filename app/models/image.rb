class Image
  include Mongoid::Document
  field :title, type: String
  mount_uploader :image, ImageUploader
  embedded_in :report
end
