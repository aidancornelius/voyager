class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_api, except: [:index]
  before_action :set_endpoint, except: [:index, :add_subscription]
  before_action :require_administrator!

  def index
  end

  def check_subscribed_status
    if check_opt_status(current_user.mobile_number)["is_opted_out"] == false
      unique = SecureRandom.uuid[0...8]
      current_user.sns_endpoint.send_message("Hello, this is a test message from Assessment Ninja. Code: #{unique}.")
      redirect_to "/notifications", notice: "You are subscribed, a test message should arrive shortly with the code: #{unique}."
    else
      redirect_to "/notifications", notice: "You are not subscribed."
    end
  end

  def add_subscription
    if params[:mobile_number] =~ /^\+?[1-9]\d{1,14}$/
      current_user.mobile_number = params[:mobile_number]
      current_user.save
      @result = create_endpoint(params[:mobile_number])
    else
      redirect_to "/notifications", alert: "Please check that your mobile number follows a number only format (no spaces), like this: [COUNTRY CODE][NO PREFIX][NUMBER] E.g. 61 4 00 200 300 without spaces."
    end
  end

  def remove_subscription
    current_user.mobile_number = nil
    current_user.save
    deactivate_endpoint
    redirect_to "/notifications", notice: "You have deactivated notifications."
  end

  private

  def set_api
    @sns = Aws::SNS::Client.new
  end

  def create_endpoint(mobile_number)
    if current_user.sns_endpoint.present?
      current_user.sns_endpoint.active = true
      current_user.sns_endpoint.save
      redirect_to "/notifications", notice: "You are subscribed."
    else
      @endpoint = SnsEndpoint.new
      proposed_topic_name = "#{current_user.id}_#{current_user.firstname.downcase}_ninja_#{SecureRandom.uuid}"
      if @sns.create_topic({
            name: proposed_topic_name,
          })
        @endpoint.user_id = current_user.id
        @endpoint.topic_name = proposed_topic_name
        @endpoint.active = true
        if @endpoint.save
          if subscribe_to_endpoint(mobile_number, proposed_topic_name)
            redirect_to "/notifications", notice: "You are subscribed."
          else
            redirect_to "/notifications", notice: "You are not subscribed."
          end
        else
          redirect_to "/notifications", notice: "You are not subscribed."
        end
      else
        redirect_to "/notifications", notice: "You are not subscribed."
      end
    end
  end

  def subscribe_to_endpoint(mobile_number, topic_name)
    @sns.subscribe({
      topic_arn: "arn:aws:sns:us-east-1:497955459185:#{topic_name}", # required
      protocol: "sms",
      endpoint: mobile_number,
    })
  end

  def deactivate_endpoint
    if @endpoint.present?
      @endpoint.active = false
      @endpoint.save
    end
  end

  def set_endpoint
    if @endpoint = SnsEndpoint.find_by_user_id(current_user.id)
      return @endpoint
    else
      false
    end
  end

  def check_opt_status(mobile_no)
    @sns.check_if_phone_number_is_opted_out({
      phone_number: mobile_no,
    })
  end
end
