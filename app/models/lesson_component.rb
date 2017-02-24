class LessonComponent < ApplicationRecord
  belongs_to :lesson
  has_many :replies

  validates :lesson, :style, :order, :title, :body, presence: true

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/ }

  has_attached_file :feature, styles: { xxlarge: "1500x1500>", xlarge: "1000x1000>", large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.jpg", :s3_permissions => 'private', :path => "/component_feature/:lesson_id/:id/:style/:basename.:extension"
  validates_attachment_content_type :feature, content_type: /\Aimage\/.*\z/

  def to_param
    "#{self.lesson_id}_#{self.order}"
  end
end
