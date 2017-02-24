class Image < ApplicationRecord
  has_attached_file :image, styles: { xxlarge: "1500x1500>", xlarge: "1000x1000>", large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.jpg", :s3_permissions => 'private', :path => "/image_attachment/:id/:style/:basename.:extension"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :title, presence: true
end
