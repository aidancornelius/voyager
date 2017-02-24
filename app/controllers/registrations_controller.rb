class RegistrationsController < Devise::RegistrationsController

  def edit
    require 'digest/md5'
    gibbon = Gibbon::Request.new
    @mc_status = gibbon.lists("5eaf4f79b8").members(Digest::MD5.hexdigest(@user.email)).retrieve
    super
  end

  private

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
      edit_user_registration_path
  end

  def sign_up_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password, :email_preference)
  end
end
