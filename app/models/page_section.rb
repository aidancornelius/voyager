class PageSection < ApplicationRecord
  belongs_to :page
  validates :order, :title, :body, presence: true
end
