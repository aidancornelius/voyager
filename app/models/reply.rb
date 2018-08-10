class Reply < ApplicationRecord
  include ActionView::Helpers::DateHelper

  validates :body, :user_id, presence: true

  after_create :notify_anchannel

  belongs_to :lesson_component
  belongs_to :user

  belongs_to :reply, optional: true
  has_many :replies

  def notify_anchannel
    ac = ApplicationController.new
    attachments = {
        fallback: 'Failed to retrieve details... :frowning:',
        text: "Name: #{self.user.name} \nInfo: #{self.descriptive} \nReply : #{self.body}",
        color: '#536531'
    }
    ac.notify_slack('there is a new reply at [Natural Maths](https://naturalmaths.com.au/replies).', attachments)
  end

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
