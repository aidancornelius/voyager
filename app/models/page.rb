class Page < ApplicationRecord
  has_many :page_sections

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/ }
  validates :title, :author, :description, presence: true

  def to_param
    slug
  end
end
