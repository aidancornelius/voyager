class NotificationMailer < ApplicationMailer
  def notification(email, title, link)
    @title = title
    @link = link
    mail( to: email )
  end
end
