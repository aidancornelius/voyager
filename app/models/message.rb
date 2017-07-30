class Message < ApplicationRecord
  belongs_to :user

  after_create :notify_and_upsert

  def notify_and_upsert
    if self.user.present?
       NotificationMailer.notification(self.user.email, self.title, "https://naturalmaths.com.au/messages").deliver
     end
  end
end
