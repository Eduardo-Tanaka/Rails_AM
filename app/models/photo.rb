class Photo < ActiveRecord::Base
  belongs_to :donation
  mount_uploader :image, ImageUploader

end
