class SplashController < ApplicationController
  def index
    if current_user_purchased?
      redirect_to dashboard_path
    elsif current_user && !current_user_purchased?
      redirect_to new_billing_path
    else
      if Page.find_by_slug("home")
        @page = Page.find_by_slug("home")
      else
        @render = "Core not setup properly. :("
      end
    end
  end

  def school_purchase
    @school_purchase = SchoolPurchase.new
  end

  def check_school_code
    @school_purchase = SchoolPurchase.find_by_code(params[:code])
    if @school_purchase.present?
      render json: @school_purchase.to_json
    else
      render json: {}
    end
  end

  def landing
    @landing = Landing.find_by_slug_before(params[:landing_slug])
    @before = true
    if !@landing
      @landing = Landing.find_by_slug_after(params[:landing_slug])
      @before = false
    end
    if !@landing
      redirect_to root_url, notice: "Sorry, we couldn't find that page!"
    else
      if @before == false
        redirect_to @landing.download.expiring_url(50)
      else
        render "landing", layout: false
      end
    end
  end

  def subscribe
    @landing = Landing.find_by_id(params[:landing_id])
    if !@landing
      redirect_to root_url, notice: "Sorry, we couldn't find that page!"
    else
      if params[:email].present?
        attachments = {
          fallback: "Failed to retrieve details... :frowning:",
          text: "Email: #{params[:email]} \n List ID: #{@landing.mailchimp_list}",
          color: "#a1cd74"
        }
        notify_slack("someone joined a landing page list at Assessment Ninja.", attachments)

        begin
          gibbon = Gibbon::Request.new
          gibbon.lists(@landing.mailchimp_list).members(Digest::MD5.hexdigest(params[:email])).upsert(body: {email_address: params[:email], status: "subscribed"})
          redirect_to "/l/#{@landing.slug_before}", notice: "Thank you! Please check your emails for your download link."
        rescue Gibbon::MailChimpError => e
          redirect_to "/l/#{@landing.slug_before}", alert: "You need to enter your email address..."
        end
      else
        redirect_to "/l/#{@landing.slug_before}", alert: "You need to enter your email address..."
      end
    end
  end
end
