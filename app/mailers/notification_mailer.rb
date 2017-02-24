class NotificationMailer < ApplicationMailer
  def notification(email, title, link)
    @title = title
    @link = link
    mail( to: email )
  end

  def school_po(email, code, school_name, contact_name, contact_email, billing_address)
    @school_name = school_name
    @contact_name = contact_name
    @contact_email = contact_email
    @billing_address = billing_address
    @code = code
    mail( to: email, bcc: "hello@teachersolutions.com.au")
  end
end
