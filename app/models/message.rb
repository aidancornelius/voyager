class Message < ApplicationRecord
  belongs_to :user

  after_create :notify_and_upsert

  def notify_and_upsert
      ac = ApplicationController.new
      attachments = {
          fallback: 'Failed to retrieve details... :frowning:',
          text: "Name: #{self.user.name} \nMessage Title: #{self.title}",
          color: '#d062a5'
      }
      if self.user.present?
         if self.user.email_preference != false
           NotificationMailer.notification(self.user.email, self.title, "https://assessmentninja.com/messages").deliver
         end

         if self.user.id == 1
           ac.notify_slack('there is a new message waiting for you at [Assessment Ninja](https://assessmentninja.com/messages).', attachments, "aidancornelius")
         elsif self.user.id == 2
           ac.notify_slack('there is a new message waiting for you at [Assessment Ninja](https://assessmentninja.com/messages).', attachments, "karencornelius")
         else
           ac.notify_slack('there is new activity at [Assessment Ninja](https://assessmentninja.com/messages).', attachments)
         end
       end
  end
end
