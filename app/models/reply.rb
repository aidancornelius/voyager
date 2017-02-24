class Reply < ApplicationRecord
  include ActionView::Helpers::DateHelper

  validates :body, :user_id, presence: true

  belongs_to :lesson_component
  belongs_to :user

  belongs_to :reply, optional: true
  has_many :replies

  def thread_id
    if self.reply.present?
      return self.reply.id
    else
      false
    end
  end

  def descriptive
    self.user.firstname + " - " + time_ago_in_words(self.created_at) + " ago"
  end

  def when_was_it
    time_ago_in_words(self.created_at) + " ago"
  end
end
