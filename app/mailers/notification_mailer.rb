class NotificationMailer < ApplicationMailer
  def notification(email, title, link)
    @title = title
    @link = link
    mail( to: email )
  end

  def new_message(email, user, link)
    @user = user
    @link = link
    mail( to: email )
  end
end
