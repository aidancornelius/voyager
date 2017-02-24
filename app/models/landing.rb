class Landing < ApplicationRecord
  has_attached_file :download, default_url: "/images/missing.jpg", :s3_permissions => 'private', :path => "/landing_files/:id/:basename.:extension"
  validates_attachment :download, content_type: { content_type: "application/pdf" }

  validates :title, :slug_before, :slug_after, :body_before, :body_after, :mailchimp_list, presence: true
  validates :slug_before, :slug_after, uniqueness: true, format: { with: /\A[a-z0-9-_]+\z/ }
end
