class InboxController < ApplicationController
  include Mandrill::Rails::WebHookProcessor

  # To completely ignore unhandled events (not even logging), uncomment this line
  # ignore_unhandled_events!

  # If you want unhandled events to raise a hard exception, uncomment this line
  # unhandled_events_raise_exceptions!

  # To enable authentication, uncomment this line and set your API key.
  # It is recommended you pull your API keys from environment settings,
  # or use some other means to avoid committing the API keys in your source code.
  # authenticate_with_mandrill_keys! 'fQRsKUJShGJIHEAJqegAgw'

  def handle_inbound(event_payload)
    head(:ok)
    if event_payload['msg']
      message_user(1, "Message from Mandrill WHP on #{Time.now.strftime("%B %-d at %-l:%M %P")}", event_payload['msg'], "#mandrill_whp_api")
    end
  end
end
