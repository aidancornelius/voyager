class Completion < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_component

  validates :user_id, :lesson_component_id, presence: true
end
