class NotificationMailer < ApplicationMailer
  def notification(email, title, link)
    @title = title
    @link = link
    mail( to: email, bcc: "annbaker111@gmail.com, aidan@teachersolutions.com.au" )
  end
end
