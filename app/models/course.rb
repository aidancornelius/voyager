class Course < ApplicationRecord
  belongs_to :product, optional: true

  has_many :lessons
end
