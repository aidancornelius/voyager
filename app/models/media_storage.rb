class MediaStorage < ApplicationRecord
  has_attached_file :file, default_url: "/images/missing.jpg", :s3_permissions => 'private', :path => "/an_media_usa/:id/:basename.:extension"
  validates_attachment :file, content_type: { content_type: "application/pdf" }

  validates :title, presence: true, uniqueness: true
end
