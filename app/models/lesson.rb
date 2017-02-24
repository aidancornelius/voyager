class Lesson < ApplicationRecord
  acts_as_taggable

  has_many :lesson_components

  belongs_to :course

  ActsAsTaggableOn.force_lowercase = true
  ActsAsTaggableOn.remove_unused_tags = true
  ActsAsTaggableOn.delimiter = ' '

  validates :title, :slug, :author, :description, :unlock, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/ }
end
