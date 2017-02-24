class ProfileController < ApplicationController
  before_action :require_administrator!, except: :show

  def index
    @users = User.all.order(:created_at)
  end

  def show
    @user = User.find(params[:id])
    if !@user
      redirect_to root_url, notice: "We couldn't find a user with that identifier! Sorry."
    else
      if !@user.last_sign_in_at.present?
        redirect_to root_url, notice: "Sorry, that user has not verified their account, or has been banned!"
      end
      @replies = Reply.where(user_id: @user).last(10)
      if @user.billing.present? && @user.billing.data.present? && JSON.parse(@user.billing.data)
        if @user.billing.data.is_a?(Hash)
          @data = "#{@user.billing.data.inspect}"
        else
          @data = JSON.parse(@user.billing.data).inspect
        end
      else
        @data = "nil"
      end
    end
  rescue
    @data = "nil"
    true
  end

  def update
    @user = User.find(params[:id])
    if @user.update(permitted)
      redirect_to profile_path(@user), notice: "User updated successfully."
    else
      redirect_to profile_path(@user), alert: "Could not update that user..."
    end
  end

  def delete
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to profile_path(@user), notice: "User destroyed successfully."
    else
      redirect_to profile_path(@user), alert: "Could not destroy that user..."
    end
  end
end
